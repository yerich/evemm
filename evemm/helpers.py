import re

__test__ = {}

re_digits_nondigits = re.compile(r'\d+|\D+')

__test__['re_digits_nondigits'] = r"""

    >>> re_digits_nondigits.findall('$1234.1234')
    ['$', '1234', '.', '1234']
    >>> re_digits_nondigits.findall('1234')
    ['1234']
    >>> re_digits_nondigits.findall('')
    []
    
"""

def FormatWithCommas(format, value):
    parts = re_digits_nondigits.findall(format % (value,))
    for i in xrange(len(parts)):
        s = parts[i]
        if s.isdigit():
            parts[i] = _commafy(s)
            break
    return ''.join(parts)
    
def _commafy(s):

    r = []
    for i, c in enumerate(reversed(s)):
        if i and (not (i % 3)):
            r.insert(0, ',')
        r.insert(0, c)
    return ''.join(r)