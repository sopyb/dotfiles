from typing import List

from kitty.boss import Boss
from kitty.tabs import Tab
from kittens.tui.handler import result_handler


def main(args: List[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    if len(args) != 2:
        return
    direction = args[1]
    if direction not in ('left', 'right'):
        return

    tm = boss.active_tab_manager
    tab = boss.active_tab
    if tm is None or tab is None:
        return

    def neighboring_window(t: Tab, which: str) -> bool:
        neighbor = t.neighboring_group_id(which)
        if neighbor is not None:
            t.windows.set_active_group(neighbor)
            return True
        return False

    if neighboring_window(tab, direction):
        return
    elif len(tm.tabs) > 1:
        if direction == 'left':
            boss.previous_tab()
        else:
            boss.next_tab()

        tab = boss.active_tab
        if tab is not None and len(tab.windows) > 1:
            direction = 'right' if direction == 'left' else 'left'
            while neighboring_window(tab, direction):
                continue