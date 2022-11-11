import pytest

from app.modules.module_a.arithmetic_operations import sum_values, multiply_values


@pytest.mark.parametrize("a, b, c", [(10, 20, 30), (2, 4, 6), (11, 33, 44)])
def test_sum(a, b, c):
    res = sum_values(a, b)
    assert res == c

@pytest.mark.parametrize("a, b, c", [(10, 2, 20), (2, 4, 8), (11, 1, 11)])
def test_multiply(a, b, c):
    res = multiply_values(a, b)
    assert res == c