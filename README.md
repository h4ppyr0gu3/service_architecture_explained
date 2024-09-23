## Service architecture

### Pros:

- Use of memoization
- only one way to call the service
- inheratance allows for sweeping changes accross all services in one file
- easy(ish) to test
- easy to stub
- error handling is consistend
- fail fast methodology

### Cons:

- Naming of classes becomes a verb and is more complex
- A lot of boilerplate in place to make it work

## Aggregate_failures rspec: 

### Pros:

- it allows you to see which exact expectation is failing from a list
- when you break a test that has multiple expectations, you can isolate the impact of your change

### Cons:

- it doesn't provide any benefit when you have a green test suite
