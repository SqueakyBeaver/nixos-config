import workspaces from './parts/workspaces.js';
import notifications from './parts/notifications.js';

const Start = () => Widget.Box({
    hexpand: true,
    hpack: "start",
    children: [
        workspaces(),
    ]
});

const End = () => Widget.Box({
    hexpand: true,
    hpack: "end",
    children: [
        notifications(),
    ]
});



export default () => Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',

    child: Widget.CenterBox({
        className: 'bar',
        css: 'min-height: 32px;',

        startWidget: Start(),
        // centerWidget: null,
        endWidget: End(),
    })
});