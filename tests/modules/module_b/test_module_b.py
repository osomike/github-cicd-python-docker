import pytest

from app.modules.module_b.identity_operations import identity


@pytest.mark.parametrize("a, b", [(10, 10), (2, 2), ("A", "A")])
def test_identity(a, b):
    res = identity(a)
    assert res == b