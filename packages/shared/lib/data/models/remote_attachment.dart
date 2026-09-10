// * the server's permanent refusals, as a plain type. Both mean the same thing
// * to the queue: stop, do not retry. A retryable failure is anything else
class const AttachmentRefusedException(final String reason) implements Exception;
