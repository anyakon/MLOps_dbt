def safe_divide(numerator, denominator):
    return f"({numerator}) / nullif(({denominator}), 0)"
