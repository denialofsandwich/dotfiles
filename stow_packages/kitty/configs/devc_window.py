"""Open a new window like the active one: a devc shell in a devc window, else a shell in its cwd."""

import shutil
from pathlib import Path

from kittens.tui.handler import result_handler
from kitty.boss import Boss
from kitty.child import environ_of_process
from kitty.window import Window

PROJECT_ENV = "DEVC_PROJECT"


def main(args: list[str]) -> str:
    return ""


def _devc_environ(window: Window) -> dict[str, str] | None:
    """Return the environment of the devc session running in the window, if any."""
    for proc in window.child.foreground_processes:
        try:
            env = environ_of_process(proc["pid"])
        except Exception:
            continue
        if PROJECT_ENV in env:
            return env
    return None


def _session_path(env: dict[str, str]) -> str:
    venv = env.get("VIRTUAL_ENV")
    venv_bin = Path(venv) / "bin" if venv else None
    return ":".join(p for p in env.get("PATH", "").split(":") if Path(p) != venv_bin)


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    w = boss.window_for_dispatch or boss.active_window_for_cwd
    env = _devc_environ(w) if w else None
    if env is None:
        boss.new_window_with_cwd()
        return

    project = env[PROJECT_ENV]
    path = _session_path(env)
    boss.launch(
        "--type=window",
        f"--cwd={project}",
        "--env", f"PWD={project}",
        "--env", f"PATH={path}",
        shutil.which("devc", path=path) or "devc",
    )  # fmt: skip
