# Coding challenge 

Write a Swift App that uses the [Random Data API: Cards](https://random-data-api.com/api/v2/credit_cards?size=100):
- Display the fetched cards
- Sort/Group cards by type
- Option to bookmark or save cards
- Proper error handling and display appropriate error messages if the API’s fail.

## Asks:
- SwiftUI
- Usage of any third-party libraries is not allowed
- Folder structuring
- SwiftUI navigation approach
- Handle loading states, e.g. without a loading indicator or using Pagination
- Upload your project via a public remote repo (GitHub/GitLab/Bitbucket, etc.) and send the link to this email once done.

## Additional notes from dev @leojquinteros

- I have used the suggested API for fetching credit cards. I copied and pasted all of them into a local JSON file to work with during development (so I did not hit the API too many times, I was not sure whether we have some sort of quota as developers). I have built a specific data service for that purpose. Please change the CreditCardsViewModel initializer to use the remote service instead:

```
    init(
        service: CreditCardServiceProtocol = CreditCardService(),
        favouritesManager: FavouritesManagerProtocol = FavouritesManager()
    ) {
        // ...
    }
```

- I haven't done UI tests for the challenge (I would have chosen POM for this), but I covered all the views with SwiftUI previews, so I can make sure everything looks and behaves correctly.

- Thanks for the opportunity!
