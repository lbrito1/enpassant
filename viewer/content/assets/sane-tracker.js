console.log("Hello! Not to worry, I'm just getting the userAgent, location and IP for this request. You can check the code yourself at https://github.com/lbrito1/sane-tracker-js. Happy coding!")
const HOSTNAME = "https://android-analytics.duckdns.org"
const PATH = "/update-blog-stats"

function sane_track() {
  fetch(HOSTNAME + PATH, {
    body: "token=M1mI0c53WcDu2FD0EIvQOdNlS9gWQtyh&url=" + window.location,
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    method: "POST"
  })
}
