# Building a Networking Layer That Stays Out of the Way

Networking is part of almost every Flutter application.

Users log in.

Data is loaded.

Images are uploaded.

Settings are synchronized.

Most applications spend a significant amount of time communicating with a server.

Because of that, the networking layer should be predictable.

It shouldn't surprise the rest of the application.

It shouldn't leak implementation details into the UI.

And it shouldn't become something developers are afraid to change.

The goal isn't to build a clever networking layer.

The goal is to build one that quietly does its job.

---

## Keep the UI Unaware

A screen shouldn't know how an API works.

It shouldn't know which HTTP client is being used.

It shouldn't know where authentication tokens are stored.

Those details belong somewhere else.

The UI should ask for data.

The networking layer should decide how that data is retrieved.

Keeping those responsibilities separate makes both parts easier to change.

---

## Why I Use Dio

Flutter has more than one way to make HTTP requests.

For small experiments, almost any solution works.

For larger projects, I prefer Dio because it provides the features I end up needing sooner or later.

Interceptors.

Request cancellation.

Timeouts.

File uploads.

Custom configuration.

Good error handling.

None of these features make an application better on their own.

They simply reduce the amount of custom code that would otherwise need to be written and maintained.

---

## One Place for Configuration

Network configuration shouldn't be scattered throughout the project.

The base URL.

Headers.

Timeouts.

Authentication.

Logging.

These settings belong in one place.

When configuration is centralized, changing environments or updating an API becomes much simpler.

Developers know exactly where to look instead of searching through multiple files.

---

## Repositories Shouldn't Know HTTP

One idea has saved me a lot of refactoring over the years.

Repositories shouldn't care how data is fetched.

Whether the request comes from Dio, another HTTP client, local storage, or even mocked data during testing shouldn't matter.

A repository asks for data.

A data source knows how to retrieve it.

Keeping those responsibilities separate makes replacing implementation details much less painful later.

---

## Expect Requests to Fail

Network requests fail.

Connections drop.

Servers become unavailable.

Tokens expire.

Users lose internet access.

None of these situations are unusual.

For that reason, I try to design the networking layer with failure in mind instead of treating it as an exception.

Handling failure consistently usually leads to a better user experience than trying to prevent every possible error.

---

## Returning Meaningful Errors

Raw exceptions rarely help the rest of the application.

A timeout.

A cancelled request.

An unauthorized response.

A server error.

Each of these situations should be translated into something the application understands.

The UI shouldn't care about Dio exceptions.

It should receive information that helps it decide what to show the user.

That keeps networking details inside the networking layer, where they belong.


## Token Refresh

Authentication eventually expires.

That's normal.

Refreshing an expired token shouldn't become the responsibility of every API call.

The networking layer should handle that automatically whenever possible.

That keeps authentication logic in one place and prevents the same code from being repeated across the project.

If refreshing the token fails, the application should have one predictable way of handling it.

Unexpected authentication behavior is frustrating for both developers and users.

---

## Logging

Network logs are extremely useful during development.

They're much less useful in production.

I keep detailed request and response logging enabled while developing, but I avoid exposing unnecessary information in release builds.

Logs should help solve problems.

They shouldn't create new ones.

---

## Retry

Retrying every failed request sounds helpful until duplicate actions start appearing.

Not every request should be repeated automatically.

Loading a list of products is usually safe.

Submitting a payment usually isn't.

The networking layer should understand the difference.

Retries should be intentional, not automatic.

---

## Common Mistakes

Most networking problems aren't caused by the HTTP client.

They're caused by architecture.

Fetching data directly from widgets.

Repeating request logic in multiple places.

Ignoring timeouts.

Returning raw exceptions.

Mixing business rules with networking code.

Small shortcuts like these don't cause immediate problems.

They become expensive once the project starts growing.

---

## Final Thoughts

Networking should be one of the quietest parts of the application.

Once it's configured, most developers shouldn't have to think about it very often.

When requests are predictable, errors are handled consistently, and responsibilities are clearly separated, the rest of the project becomes much easier to maintain.

A good networking layer rarely gets attention.

That's usually a sign that it's doing exactly what it was designed to do.
