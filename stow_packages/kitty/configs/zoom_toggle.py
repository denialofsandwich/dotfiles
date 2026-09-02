from kitty.boss import Boss


def main(args: list[str]) -> str:
    pass


from kittens.tui.handler import result_handler


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    tab = boss.active_tab
    if tab is None:
        return

    if len(tab.windows) > 1:
        tab.first_window()
        tab.toggle_layout("stack")
    elif tab.current_layout.name == "stack":
        # Falls versehentlich noch im Stack-Layout bei nur 1 Fenster, zurückwechseln
        tab.toggle_layout("stack")
