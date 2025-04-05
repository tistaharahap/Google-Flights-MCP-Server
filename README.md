# Google Flights MCP Server

This MCP server provides tools to interact with Google Flights data using the bundled `fast_flights` library.

## Features

Provides the following MCP tools:

*   **`get_flights_on_date`**: Fetches available one-way flights for a specific date between two airports.
    *   Args: `origin` (str), `destination` (str), `date` (str, YYYY-MM-DD), `adults` (int, optional), `seat_type` (str, optional).
*   **`get_round_trip_flights`**: Fetches available round-trip flights for specific departure and return dates.
    *   Args: `origin` (str), `destination` (str), `departure_date` (str, YYYY-MM-DD), `return_date` (str, YYYY-MM-DD), `adults` (int, optional), `seat_type` (str, optional).
*   **`find_cheapest_flights_in_range`**: Finds the cheapest round-trip flight within a specified date range.
    *   Args: `origin` (str), `destination` (str), `start_date_str` (str, YYYY-MM-DD), `end_date_str` (str, YYYY-MM-DD), `min_stay_days` (int, optional), `max_stay_days` (int, optional), `adults` (int, optional), `seat_type` (str, optional).

## Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd flight_mcp_server
    ```
2.  **Create a virtual environment (recommended):**
    ```bash
    python -m venv .venv
    source .venv/bin/activate  # On Windows use `.venv\Scripts\activate`
    ```
3.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
4.  **Install Playwright browsers (needed by `fast_flights`):**
    ```bash
    playwright install
    ```

## Running the Server

You can run the server directly using Python:

```bash
python server.py
```

The server uses STDIO transport by default.

## Integrating with MCP Clients (e.g., Cline, Claude Desktop)

Add the server to your MCP client's configuration file. Example for `cline_mcp_settings.json` or `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "google-flights": {
      "command": "/path/to/your/.venv/bin/python", // Use absolute path to venv python
      "args": [
        "/absolute/path/to/flight_mcp_server/server.py" // Use absolute path to server script
      ],
      "env": {},
      "disabled": false,
      "autoApprove": []
    }
    // ... other servers
  }
}
```

**Important:** Replace the paths in `command` and `args` with the absolute paths to your virtual environment's Python executable and the `server.py` script on your system.

## Notes

*   This server bundles the `fast_flights` library (originally from [https://github.com/AWeirdDev/flights](https://github.com/AWeirdDev/flights)) for its core flight scraping functionality. Please refer to the included `LICENSE` file for its terms.
*   Flight scraping can sometimes be unreliable or slow depending on Google Flights changes and network conditions. The tools include basic error handling.
*   The `find_cheapest_flights_in_range` tool can be resource-intensive as it checks many date combinations.
