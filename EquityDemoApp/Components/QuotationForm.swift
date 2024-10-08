//
//  QuotationForm.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 8/10/24.
//

import SwiftUI
import Sis11Framework

// A view that represents a quotation form for a product.
struct QuotationForm: View {
    // State variable to hold the product data.
    @State var product: Product
    // State variable to indicate whether the configuration is loading.
    @State var loadingConfig = false
    // State variable to hold the HTML content of the form.
    @State var htmlContent: String? = String()
    // State variable to hold the dynamic form.
    @State private var dynamicForm: DynamicForm?
    // State variable to control navigation to the quotation result.
    @State private var showQuotationResult = false
    // State variable to indicate whether the form is being submitted.
    @State private var quoting = false
    // State variable to hold newly created policies.
    @State private var newPolicies: [LifePolicy]?

    var body: some View {
        VStack {
            // Show a loading indicator if the configuration is being loaded.
            if loadingConfig {
                ProgressView()
            } else {
                // Display the dynamic form when it's ready.
                dynamicForm?.onAppear {
                    self.htmlContent = htmlContent // Set the HTML content.
                }.frame(minHeight: 300)
                
                // Submit button to send the form data.
                Button(action: submitForm, label: {
                    HStack {
                        if quoting {
                            ProgressView() // Show a loading indicator while quoting.
                        } else {
                            Text("Submit") // Display the submit text.
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 40)
                })
                .buttonStyle(.borderedProminent) // Use a prominent button style.
                .disabled(quoting) // Disable the button while quoting.
                .padding(.top) // Add top padding.
            }

            // Navigation link to show the quotation result.
            NavigationLink(destination: QuoteResult(newPolicies: newPolicies ?? [LifePolicy]()), isActive: $showQuotationResult) {
                EmptyView() // Placeholder for the navigation link.
            }
        }
        .navigationTitle("Quotation Form") // Set the title for the navigation bar.
        .task {
            do {
                // Parse the product configuration to get the HTML content.
                let config = try SDK.portal.ParseProductConfig(product: product)
                htmlContent = config.SelfService.Quote.mobileForm ?? String()
                dynamicForm = DynamicForm(htmlContent: $htmlContent, additionalFunctions: .constant(String()))
            } catch {
                // Handle errors and display an error message.
                htmlContent = "<h1>Error loading \(product.name ?? String()) html form </h1>"
            }
        }
    }

    // Function to validate the dynamic form data.
    func validateDynamicFormData(_ formData: [String: Any]?) -> Bool {
        // Check for a valid property in the form data.
        let isValid = formData?["isValid"] as? Bool
        return isValid ?? false
    }

    // Function to submit the form data.
    func submitForm() {
        Task {
            quoting.toggle() // Start the quoting process.
            let formData = await dynamicForm?.validateFormNow() // Validate the form data.
            if !validateDynamicFormData(formData) {
                print("Form errors") // Print errors if validation fails.
                quoting.toggle() // End the quoting process.
                return
            }
            if var myFormData = formData?["data"] as? [String: Any] {
                // Add contact holder ID to the form data.
                myFormData["holderId"] = String(SDK.contactData.Contact.id)
                // Make a request to quote the product.
                do {
                    let response = try await SDK.policy.QuotePortalProduct(jFormValues: myFormData, productCode: product.code)
                    newPolicies = [LifePolicy]() // Initialize the new policies array.
                    newPolicies?.append(contentsOf: response.outData) // Append the response data.
                    showQuotationResult.toggle() // Navigate to the quotation result.
                    print(response) // Print the response for debugging.
                } catch {
                    print(error) // Print any error encountered during the request.
                }
            }
            quoting.toggle() // End the quoting process.
        }
    }
}

