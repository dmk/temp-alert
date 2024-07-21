/**
 * Constructs the full API URL by appending the endpoint to the current base path.
 *
 * This function uses the browser's current location to determine the base path and appends the provided
 * endpoint to it. It ensures that any trailing slash is removed from the base path before appending the endpoint.
 *
 * @param endpoint - The API endpoint to be appended to the base path.
 * @returns The full API URL including the base path.
 */
export function getApiUrl(endpoint: string): string {
  const basePath = process.env.TA_BASE_PATH || '';
  return `${basePath}/api/v1${endpoint}`;
}
