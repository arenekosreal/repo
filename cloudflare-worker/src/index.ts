/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Bind resources to your worker in `wrangler.jsonc`. After adding bindings, a type definition for the
 * `Env` object can be regenerated with `npm run cf-typegen`.
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

export interface Env {
	REPO_URL: string;
}

export default {
	async fetch(request, env, ctx): Promise<Response> {
		const REDIRECT_CODE = 301;
		const FILE_NAME = request.url.substring(request.url.lastIndexOf("/"), request.url.length);
		console.debug("Extracted filename:", FILE_NAME);
		const PATH = request.url.substring(request.url.indexOf("/os"), request.url.lastIndexOf(FILE_NAME));
		console.debug("Extracted path:", PATH);
		let url = env.REPO_URL + PATH + FILE_NAME.replaceAll(":", ".");
		return Response.redirect(url, REDIRECT_CODE);
	},
} satisfies ExportedHandler<Env>;
