# ADR-001: AI-Assisted Firebase Testing and Error Handling

**Date:** 2026-11-11  
**Author:** [Your Name]  
**Milestone:** Lab 5 / P3  
**Tool and model used:** ChatGPT (GPT-6)

## Context

I was completing the Study Notes Flutter application for Lab 5. I needed to verify Firebase Authentication error handling and add my own meaningful tests. I wanted to keep the tests simple and avoid unnecessary dependencies.

## Prompt

```text
Help me complete my own tests for the AuthRepository.
Explain which file to modify and provide the complete code.
Make sure the tests check Firebase error messages.
```

## Result

The AI helped me write additional tests in `test/own_test.dart`.

The tests verify:
- Weak password error messages.
- Network connection error messages.
- Invalid email error messages.

The tests use the existing AuthRepository.messageFor() method without requiring a real Firebase connection.

## Rejected suggestion(s) — at least one

The AI initially suggested using mocktail and a mocked FirebaseAuth instance to test sign-in and sign-up operations. I decided not to use this approach because it introduced additional mocking complexity and was not necessary for my immediate testing requirements.

Instead, I chose simpler tests that directly verify the error message mapping 