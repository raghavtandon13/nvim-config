import React, { useState, useEffect } from "https://esm.sh/react@18?dev";
import { createRoot } from "https://esm.sh/react-dom@18/client?dev";
import * as zebar from "https://esm.sh/zebar@2";

const providers = zebar.createProviderGroup({
    battery: { type: "battery" },
    cpu: { type: "cpu" },
    date: { type: "date", formatting: "EEE dd MMM h:mm a" },
    glazewm: { type: "glazewm" },
    memory: { type: "memory" },
    network: { type: "network" },
    weather: { type: "weather" },
});

createRoot(document.getElementById("root")).render(<App />);

function App() {
    const [output, setOutput] = useState(providers.outputMap);
    useEffect(() => providers.onOutput(() => setOutput(providers.outputMap)), []);

    function getNetworkIcon(networkOutput) {
        switch (networkOutput.defaultInterface?.type) {
            case "ethernet":
                return <i className="nf nf-md-ethernet_cable"></i>;
            case "wifi":
                if (networkOutput.defaultGateway?.signalStrength >= 80) return <i className="nf nf-md-wifi_strength_4"></i>;
                else if (networkOutput.defaultGateway?.signalStrength >= 65) return <i className="nf nf-md-wifi_strength_3"></i>;
                else if (networkOutput.defaultGateway?.signalStrength >= 40) return <i className="nf nf-md-wifi_strength_2"></i>;
                else if (networkOutput.defaultGateway?.signalStrength >= 25) return <i className="nf nf-md-wifi_strength_1"></i>;
                else return <i className="nf nf-md-wifi_strength_outline"></i>;
            default:
                return <i className="nf nf-md-wifi_strength_off_outline"></i>;
        }
    }

    function getBatteryIcon(batteryOutput) {
        if (batteryOutput.chargePercent > 90) return <i className="nf nf-fa-battery_4"></i>;
        if (batteryOutput.chargePercent > 70) return <i className="nf nf-fa-battery_3"></i>;
        if (batteryOutput.chargePercent > 40) return <i className="nf nf-fa-battery_2"></i>;
        if (batteryOutput.chargePercent > 20) return <i className="nf nf-fa-battery_1"></i>;
        return <i className="nf nf-fa-battery_0"></i>;
    }

    function getWeatherIcon(weatherOutput) {
        const weatherIcons = {
            clear_day: <i className="nf nf-weather-day_sunny"></i>,
            clear_night: <i className="nf nf-weather-night_clear"></i>,
            cloudy_day: <i className="nf nf-weather-day_cloudy"></i>,
            cloudy_night: <i className="nf nf-weather-night_alt_cloudy"></i>,
            light_rain_day: <i className="nf nf-weather-day_sprinkle"></i>,
            light_rain_night: <i className="nf nf-weather-night_alt_sprinkle"></i>,
            heavy_rain_day: <i className="nf nf-weather-day_rain"></i>,
            heavy_rain_night: <i className="nf nf-weather-night_alt_rain"></i>,
            snow_day: <i className="nf nf-weather-day_snow"></i>,
            snow_night: <i className="nf nf-weather-night_alt_snow"></i>,
            thunder_day: <i className="nf nf-weather-day_lightning"></i>,
            thunder_night: <i className="nf nf-weather-night_alt_lightning"></i>,
        };
        return weatherIcons[weatherOutput.status] || null;
    }

    function getBetterName(focusedContainer) {
        const processName = focusedContainer?.processName?.toLowerCase();
        const key = processName === "applicationframehost" ? focusedContainer?.title.toLowerCase() : processName;
        const map = {
            "microsoft store": "STORE",
            "wezterm-gui": "WEZTERM",
            fpilot: "EXPLORER",
            msedge: "EDGE",
            msedgewebview2: "EDGE DEVTOOLS",
            pgadmin4: "PG ADMIN",
            mongodbcompass: "COMPASS",
        };
        return map[key] || key.toUpperCase();
    }

    return (
        <div className="app">
            <div className="left">
                <i className="nf nf-fa-cat" style={{ marginRight: "16px" }}></i>
                {output.glazewm && (
                    <div className="workspaces">
                        {output.glazewm.currentWorkspaces.map((workspace) => (
                            <button
                                className={`workspace ${workspace.hasFocus && "focused"} ${workspace.isDisplayed && "displayed"}`}
                                onClick={() => output.glazewm.runCommand(`focus --workspace ${workspace.name}`)}
                                key={workspace.name}
                            >
                                {workspace.displayName ?? workspace.name}
                            </button>
                        ))}
                        {output.glazewm?.focusedContainer?.processName && (
                            <button className={"workspace focused displayed"}>{getBetterName(output.glazewm?.focusedContainer)}</button>
                        )}
                    </div>
                )}
            </div>
            <div className="center">
                {(() => {
                    const fullDate = output.date?.formatted || "";
                    const timeMatch = fullDate.match(/\d{1,2}:\d{2} [AP]M/);
                    const time = timeMatch ? timeMatch[0] : "";
                    const beforeTime = time ? fullDate.split(time)[0].trim() : fullDate;
                    return (
                        <>
                            {beforeTime.toUpperCase()}{" "}
                            <span style={{ marginLeft: "10px", textShadow: "0 0 3px rgba(255, 255, 255, 0.7)", color: "pink" }}>{time}</span>
                        </>
                    );
                })()}
                <span style={{ marginLeft: "10px" }}>{output.weather && getWeatherIcon(output.weather)}</span>
            </div>
            <div className="right">
                {output.network && (
                    <div className="network">
                        {getNetworkIcon(output.network)}
                        {output.network.defaultGateway?.ssid.slice(0, 8).toUpperCase()}
                    </div>
                )}
                {output.memory && (
                    <div className="memory">
                        <i className="nf nf-fae-chip"></i>
                        {Math.round(output.memory.usage)}%
                    </div>
                )}

                {output.cpu && (
                    <div className="cpu">
                        <i className="nf nf-oct-cpu"></i>
                        {/* Change the text color if the CPU usage is high. */}
                        <span className={output.cpu.usage > 85 ? "high-usage" : ""}>{Math.round(output.cpu.usage)}%</span>
                    </div>
                )}

                {output.battery && (
                    <div className="battery">
                        {/* Show icon for whether battery is charging. */}
                        {output.battery.isCharging && <i className="nf nf-md-power_plug charging-icon" style={{ color: "yellow" }}></i>}
                        {getBatteryIcon(output.battery)}
                        {Math.round(output.battery.chargePercent)}%
                    </div>
                )}
            </div>
        </div>
    );
}
