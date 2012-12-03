import re
from django import template
from validate import is_string
from pythonutils.validate import is_float
import math

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
register = template.Library()
@register.filter
def floatFormat(value, format):
	if(value == None or value == ''):
		return None;
	
	parts = re_digits_nondigits.findall(format % (value,))
	for i in xrange(len(parts)):
		s = parts[i]
		if s.isdigit():
			parts[i] = _commafy(s)
			break
	return ''.join(parts)

@register.filter
def round_to_1(value):
	if(value == None or value == ''):
		return None;
	return round(value, -int(math.floor(math.log10(value))))

def _commafy(s):

	r = []
	for i, c in enumerate(reversed(s)):
		if i and (not (i % 3)):
			r.insert(0, ',')
		r.insert(0, c)
	return ''.join(r)