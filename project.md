# NoxCollect — Project Specification

## 1. Project Overview

NoxCollect is a mobile-first application for collectors of trading cards.

The first version of NoxCollect will focus exclusively on **Pokémon cards**, but the system should be designed so that other trading card games can potentially be supported in the future.

The core purpose of NoxCollect is to make it extremely easy for users to digitize, organize, track, and understand the value of their physical card collection.

A user should be able to take out their phone, scan a Pokémon card with the camera, identify the exact card, and add it to their personal collection with as little friction as possible.

## 2. Core Product Principle

The most important principle behind NoxCollect is:

**It should be fast, simple, and free to scan a card and add it to your collection.**

Card scanning must not be locked behind a paid subscription.

Monetization should not interfere with the core collection experience.

---

# 3. Core Features

## 3.1 Card Scanning

Users should be able to use their phone camera to scan a Pokémon card.

The system should attempt to identify the exact card using relevant information such as:

* Pokémon/card name
* Card number
* Set
* Artwork
* Set symbols
* Other visual characteristics

The goal is to identify the exact printing/version of the card rather than simply identifying which Pokémon appears on it.

If the system is uncertain, it should not silently select a potentially incorrect card.

Instead, the user should be shown the most likely matches and be able to confirm the correct card manually.

Card scanning should be a core free feature of NoxCollect.

## 3.2 Manual Card Search

Scanning should not be the only way to add cards.

Users should also be able to manually search the card database.

Search should eventually support criteria such as:

* Pokémon/card name
* Card number
* Set
* Card type
* Rarity
* Artist / illustrator

Artist-based discovery should be treated as a first-class feature.

Users should be able to search for a specific card artist/illustrator, browse cards illustrated by that artist, and filter their own collection by artist.
The system should preserve artist metadata as searchable card data rather than treating it only as display information.
In the future, NoxCollect may provide dedicated artist views showing all known cards illustrated by a specific artist and which of those cards the user owns.
A user should always have a manual fallback if scanning cannot confidently identify a card.

## 3.3 Personal Collection

Each user should have their own private card collection.

For cards in their collection, users should eventually be able to store information such as:

* Card
* Quantity
* Raw or graded
* Grading company
* Grade
* Notes
* Purchase price
* Purchase date

The application should provide an easy visual overview of the entire collection.

## 3.4 Collections, Master Sets and Organization

Users should be able to organize owned cards into multiple collections without duplicating the underlying ownership data.

A user's complete inventory of owned cards should remain the source of truth for ownership, while cards may simultaneously appear in multiple organizational collections.

NoxCollect should eventually support different collection types, including:

* General/custom collections
* Set-based collections
* Master sets
* Artist-based collections
* Pokémon-specific collections
* Other user-defined collections

### Master Sets

Users should be able to create or track a master collection for a specific Pokémon set, such as Scarlet & Violet — 151.

For set-based collections, NoxCollect should be able to compare the user's owned cards against the known cards and variants required for that set and display collection progress.

This may include information such as:

* Cards owned
* Cards missing
* Total cards required
* Completion percentage
* Relevant card variants

The exact rules defining a complete “Master Set” may differ between sets and should not be permanently hardcoded into the application.

### Collection Membership

A physical owned card should not need to be duplicated in the user's inventory simply because it belongs to multiple organizational collections.

Collection membership and card ownership should therefore be modeled as separate concepts.

### Future Sharing

In the future, users may be able to share individual collections or master sets with other people.

Potential visibility levels may include:

* Private
* Accessible through a share link
* Public

Shared collections should initially be considered read-only for other users unless collaborative editing is explicitly designed and approved later.

Privacy and authorization must be enforced at the data/backend level rather than relying only on the user interface.

Collection sharing is a future feature and should not be implemented as part of the initial local scanning prototype.

## 3.5 Raw and Graded Cards

NoxCollect should distinguish between ungraded/raw cards and professionally graded cards.

The first version should at minimum support PSA grading.

Examples include:

* Raw
* PSA 10
* PSA 9
* PSA 8

The data model should not unnecessarily prevent additional grading companies from being supported later.

## 3.6 Prices and Collection Value

NoxCollect should eventually display market prices using suitable marketplaces and/or pricing data providers.

Where reliable data exists, prices should distinguish between conditions/grades such as:

* Raw
* PSA 10
* PSA 9
* PSA 8

Users should be able to see an estimated value for an individual card as well as an estimated total value for their collection.

Market values must be presented as estimates and should not imply that a card is guaranteed to sell at the displayed price.

---

# 4. Business Model

The basic NoxCollect experience should be free.

A major product differentiator is that users should **not have to pay in order to use card scanning**.

Potential monetization can be explored later.

One possible model is a limited number of advertisements rather than showing advertisements during every scan.

For example, the application could potentially show a short advertisement only a small number of times per week.

Advertising is **not part of the initial MVP** and should not be prioritized during early development.

Other monetization options can be explored later as long as they do not destroy the core free collection experience.

---

# 5. MVP — First Version

The first usable version of NoxCollect should focus on proving the core experience.

The MVP should aim to include:

* User registration and login
* Pokémon card database
* Manual card search
* Camera-based card scanning
* Card identification
* Ability to confirm or correct scan results
* Personal card collection
* Raw cards
* PSA-graded cards
* Card pricing data
* Estimated total collection value

The MVP should prioritize reliability and simplicity over having a large number of features.

Other trading card games are outside the initial MVP.

---

# 6. Future Possibilities

The architecture should avoid unnecessarily blocking future expansion.

Possible future features include:

* Additional trading card games
* Additional grading companies
* Historical price charts
* Price history
* Watchlists
* Price notifications
* Wishlists
* Purchase history
* Sales history
* Collection statistics
* Collection sharing
* Public profiles
* Trading between users
* Collection import
* Collection export
* Additional collection analytics

These are future possibilities and should **not automatically be implemented as part of the MVP**.

---

# 7. Security

Security must be considered from the beginning rather than added as an afterthought.

The project should account for areas such as:

* Secure authentication
* Secure handling of user information
* Proper password handling where applicable
* API authentication and authorization
* Users only being able to access data they are authorized to access
* Input validation
* Rate limiting where appropriate
* Protection against common API and application attacks
* Secure image upload and processing
* File type validation
* File size limitations
* Protection against abuse of the scanning system
* Secure storage of API keys
* Secure storage of secrets
* Appropriate logging
* Error monitoring
* Detection of suspicious or abusive behavior where appropriate

Secrets and credentials must never be hardcoded into the application source code or committed to source control.

---

# 8. Privacy

NoxCollect should be designed with user privacy in mind.

Images captured for card identification should not automatically be stored indefinitely.

If an image only needs to exist temporarily for card recognition, it should ideally be deleted when it is no longer required.

Permanent image storage should only be introduced when there is a clear product reason for it.

The application should avoid collecting unnecessary personal information.

---

# 9. Card Identification Principles

Card recognition is one of the most important technical challenges in NoxCollect.

The system should prioritize **correct identification over pretending to be certain**.

If confidence is low, the user should be asked to confirm the result.

The eventual identification solution may use a combination of techniques such as:

* Text recognition
* Card number recognition
* Set information
* Image matching
* Visual features
* Card database metadata

The exact implementation has **not yet been decided** and should be evaluated during technical planning.

---

# 10. External Data

NoxCollect will require external card and pricing information.

The exact providers have not yet been selected.

Before selecting a provider, the project should evaluate:

* Data quality
* Pokémon card coverage
* Update frequency
* Raw price availability
* Graded price availability
* API availability
* API limitations
* Rate limits
* Reliability
* Licensing
* Terms of service
* Cost
* Whether commercial use is permitted

Do not assume that data visible on a website can legally or technically be scraped and reused.

---

# 11. Technology

The technology stack has **not yet been finalized**.

Technologies currently worth evaluating include Flutter/Dart and Firebase, but these are possibilities rather than fixed requirements.

Before implementation begins, the architecture should evaluate the best choices for:

* Mobile application framework
* Backend
* Database
* Authentication
* Image processing
* Card recognition
* External APIs
* Hosting
* Storage
* Monitoring

Important priorities include:

1. Good mobile experience
2. Android support
3. Future iOS support
4. Camera support
5. Security
6. Maintainability
7. Low development cost
8. Low initial infrastructure cost
9. Ability to scale if NoxCollect grows
10. A codebase that remains understandable and maintainable

Do not select technologies purely because they are fashionable or because an AI agent is familiar with them.

Technical decisions should be justified based on NoxCollect's actual requirements.

---

# 12. Development Philosophy

Development should happen incrementally.

Do not attempt to build the entire application at once.

Prefer:

**Plan → Build small feature → Test → Verify → Continue**

Large architectural changes should be discussed before being implemented.

Generated code should be understandable, maintainable, and documented where appropriate.

Avoid unnecessary dependencies and unnecessary architectural complexity.

Do not implement speculative future features simply because they might eventually be useful.

The MVP comes first.

---

# 13. Current Project Status

NoxCollect is currently in the **planning and architecture phase**.

No technology stack should be considered final yet.

The next objective is to determine an appropriate architecture for the MVP.

Before writing application code, evaluate and discuss:

* Mobile technology
* Backend architecture
* Database
* Authentication
* Card data sources
* Pricing data sources
* Camera/scanning architecture
* Card recognition strategy
* Security
* Privacy
* Initial hosting/infrastructure costs

**Do not begin implementing the application until the initial architecture has been reviewed and agreed upon.**
# 14. Data Ownership and Portability

Users should retain control over their collection data.

The system should be designed so that user collections are not unnecessarily locked to a specific infrastructure provider or proprietary format.

Where practical:

* Collection data should use clear and portable data structures.
* Users should eventually be able to export their collection.
* Important application data should not depend entirely on a third-party service that cannot reasonably be replaced.
* External provider-specific identifiers should not be the only identifiers used internally for important entities.

NoxCollect should be able to change external data providers in the future without requiring the entire application to be rebuilt.

---

# 15. External Services and Vendor Independence

NoxCollect will depend on external services for some functionality, particularly card data, pricing, authentication, hosting, and potentially card recognition.

External providers should be treated as replaceable dependencies where reasonable.

Integration-specific logic should be separated from core application logic.

For example, the rest of the application should not need to understand how a specific pricing provider works.

This allows NoxCollect to replace a provider later if:

* Pricing changes
* API limits change
* The service becomes unavailable
* Data quality decreases
* Commercial usage terms change
* A better provider becomes available

Avoid unnecessary vendor lock-in.

---

# 16. Security Boundaries for AI-Assisted Development

AI coding agents may assist with development, but they should not be given unnecessary access to sensitive systems or credentials.

During development:

* Never place passwords, private keys, production credentials, or API secrets directly in source files.
* Never commit secrets to Git.
* Use environment variables or an appropriate secret-management solution.
* Development and production environments should remain separate.
* Production databases should not be used for normal development or testing.
* AI agents should not receive production credentials unless there is a specific and reviewed reason.
* Destructive database operations should require deliberate confirmation.
* Database migrations should be reviewable and reversible where practical.
* Dependencies should come from trusted sources and should not be installed unnecessarily.

Security-sensitive changes involving authentication, authorization, payments, secrets, or user privacy should receive additional review rather than being accepted solely because generated code appears to work.

---

# 17. Cost Awareness

NoxCollect should be inexpensive to develop and operate during its early stages.

When choosing infrastructure, APIs, AI services, image-processing services, databases, or other external systems, consider:

* Free-tier availability
* Expected cost per active user
* Expected cost per card scan
* API request costs
* Image-processing costs
* Storage costs
* Database costs
* Network/egress costs
* What happens to costs if usage increases significantly

A technically impressive solution should not be selected if a substantially simpler and cheaper solution can satisfy the MVP requirements.

Features that could generate significant variable costs should have appropriate limits and abuse protection.

The architecture should avoid accidentally creating a system where a malicious or automated user can generate significant infrastructure or API costs.

---

# 18. Reliability and Data Integrity

A user's collection is valuable personal data and should be treated accordingly.

The application should prioritize data integrity.

Important principles include:

* Adding the same operation twice should not accidentally create unwanted duplicates.
* Failed network requests should not corrupt collection data.
* Partial operations should fail safely.
* Important database changes should be validated.
* Destructive user actions should require appropriate confirmation.
* Appropriate backup and recovery strategies should be considered before production use.
* Errors should be logged without exposing sensitive user information.

A temporary failure in an external pricing or card-data provider should not destroy or corrupt a user's collection.

---

# 19. Source of Truth and AI Development Rules

`PROJECT.md` defines the high-level product goals and principles of NoxCollect.

Implementation details may evolve, but changes that conflict with the core product principles in this document should be discussed before being implemented.

AI coding agents should:

* Read this document before making major architectural decisions.
* Prefer simple solutions over unnecessary complexity.
* Not silently change product requirements.
* Not invent requirements merely to make implementation easier.
* Clearly identify assumptions when information is missing.
* Ask before making major irreversible architectural decisions.
* Avoid large rewrites when a smaller change can solve the problem.
* Avoid adding libraries, frameworks, or services without a concrete reason.
* Preserve existing working functionality when implementing new features.
* Test important behavior rather than assuming generated code works.
* Explain significant architectural decisions in understandable language.

When there is a conflict between convenience and security, user data integrity, or the core NoxCollect product principles, those concerns should be surfaced explicitly before proceeding.
# 20. Sustainability and Monetization Principles

NoxCollect is not initially being designed to maximize profit.

The primary financial goal is sustainability:

**NoxCollect should ideally generate enough revenue to cover its own ongoing operating costs without requiring the owner to continuously fund normal user activity out of pocket.**

## Core Free Experience

The core NoxCollect experience should remain genuinely useful for free users.

In particular:

* Card scanning should remain free.
* Scanning should not require a paid subscription.
* Users should not be given an artificially small scan allowance designed primarily to force them into a subscription.
* Core collection functionality should remain available to free users.
* Monetization should not significantly damage the scanning or collection experience.

## Advertising

Advertising may eventually be used to help cover the operating costs generated by free users.

Advertising should be deliberately low-frequency.

Ads should:

* Appear at natural breaks in the user experience.
* Never interrupt the camera while the user is actively scanning a card.
* Never appear after every scan.
* Avoid making bulk collection scanning frustrating.
* Have reasonable frequency limits.
* Be controlled by a centralized advertising policy rather than scattered throughout application code.

A possible future model could use completed scans as one input when determining when an advertisement may be shown.

For example, an advertisement could potentially become eligible after a certain number of scans.

The exact threshold must **not** be hardcoded as a permanent product requirement during early development. It should be determined later based on real user experience and operating costs.

## Optional Pro Tier

A future optional NoxCollect Pro tier may provide additional value while helping fund the service.

Potential Pro benefits may include:

* No advertisements
* Price history
* Price alerts
* Advanced collection statistics
* Advanced collection management features
* Other power-user functionality

The existence of Pro should not require intentionally making the free scanning experience poor.

## Cost-Aware Architecture

When evaluating future infrastructure and external services, NoxCollect should consider the approximate **cost per active free user**.

This includes costs such as:

* Database usage
* Authentication
* Cloud compute
* Storage
* Network traffic
* Pricing APIs
* Image processing
* AI/model inference
* Notifications
* Monitoring

When possible, functionality should run locally on the user's device when doing so provides acceptable reliability, security, and user experience.

A free feature should not casually depend on an expensive per-use cloud service when a good local alternative exists.

Before introducing a service with variable usage costs, estimate how that cost scales with user activity and consider whether the application's sustainable revenue model can reasonably support it.

The architecture should avoid situations where normal usage, abuse, bots, or unexpectedly rapid growth can generate uncontrolled infrastructure costs.

## Future Revenue Options

Other revenue sources may be evaluated later, including legitimate marketplace affiliate partnerships or similar integrations.

These are optional future possibilities and should not influence the initial prototype unless explicitly approved.
