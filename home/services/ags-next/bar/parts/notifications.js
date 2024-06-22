const notifications = await Service.import("notifications")

const popups = notifications.bind("popups");
const notifs = notifications.bind("notifications");

export default () => Widget.Box({
    class_name: "notification",
    visible: notifs.as(p => p.length > 0),
    children: [
        Widget.Icon({
            icon: "preferences-system-notifications-symbolic",
        }),
        Widget.Label({
            label: popups.as(p => p[0]?.summary || ""),
        }),
    ],
});
