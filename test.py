import sys
from playwright.sync_api import sync_playwright
from playwright.sync_api import expect

browsers = ["chromium", "firefox", "webkit"]
if len(sys.argv) != 2 or sys.argv[1] not in browsers:
    print(f"usage: {sys.argv[0]} [{'|'.join(browsers)}]")
    sys.exit(1)
browser_type = sys.argv[1]
with sync_playwright() as p:
    print(f"Running test on {browser_type}")
    browser = getattr(p, browser_type).launch()
    context = browser.new_context()
    page = context.new_page()
    page.goto("https://nixos.org/")
    expect(page.get_by_text("Declarative builds and deployments")).to_be_visible()
