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

export default {
	async fetch(request, env, ctx): Promise<Response> {
		const REDIRECT_CODE = 301;
		const PATH_NAME = URL.parse(request.url)?.pathname;
		if (PATH_NAME && (env.PREFIX?.startsWith("/") ? PATH_NAME.startsWith(env.PREFIX) : true)) {
			const TAG_START = PATH_NAME.indexOf("/os");
			if (TAG_START > 0) {
				const FILE_NAME_START = PATH_NAME.lastIndexOf("/");
				if (FILE_NAME_START > TAG_START) {
					const TAG = PATH_NAME.substring(TAG_START, FILE_NAME_START);
					console.debug("Extracted tag:", TAG);
					const FILE_NAME = PATH_NAME.substring(FILE_NAME_START, PATH_NAME.length);
					console.debug("Extracted file name:", FILE_NAME);
					const TARGET_URL = env.REPO_URL + "/releases/download" + TAG + FILE_NAME.replaceAll(":", ".");
					console.debug("Target URL:", TARGET_URL);
					return Response.redirect(TARGET_URL, REDIRECT_CODE);
				}
			}
		}
		console.debug("Invalid request found, redirecting to repo...");
		return Response.redirect(env.REPO_URL, REDIRECT_CODE);
	},
} satisfies ExportedHandler<Env>;
