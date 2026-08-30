from pathlib import Path


def draw_title(data):
    tab = data["tab"]

    if data.get("title", "").startswith("!"):
        base_title = data.get("title")[1:]
    else:
        wd = Path(tab.active_oldest_wd)
        home = Path.home()
        if wd.is_relative_to(home):
            wd = Path("~") / wd.relative_to(home)

        base_title = f"{tab.active_oldest_exe}: {wd}"

    if data.get("num_windows", 1) > 1:
        base_title = f"[{data['num_windows']}] {base_title}"

    return base_title
