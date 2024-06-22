const hyprland = await Service.import("hyprland");

const changeWorkspace = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

const Workspaces = () => {
    const activeId = hyprland.active.workspace.bind('id');
    const 

    return Widget.EventBox({
        onScrollUp: () => changeWorkspace('+1'),
        onScrollDown: () => changeWorkspace('-1'),
        child: Widget.Box({
            children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
                attribute: i,
                label: `${i}`,
                onClicked: () => changeWorkspace(i),
                classNames: [
                    String(activeId.as(id => `${i == id ? "focused" : ""}`)),
                    String()
                ]
            })),

        }),
    });
};

export default () => Widget.Box({
    className: "workspaces",
    children: [
        Workspaces(),
    ],
});