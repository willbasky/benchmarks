# benchmarks

## Validate input

Comapre approaches to validate text data.

- `validateInput` multi traversing of elem
- `validateInputAtto` usual Attoparsec parser
- `validateInputOptimized` refactored first approach. `Elem` shrinked.
- `validateInputTextIcu` regex with `PCRE`.
  It has icu library build issue. Hence it turned off.
- `validateInputRegexPosix` regex with `Posix`
- `validateInputRegexTDFA` regex with `Posix`
- `validateInputRegexPCRE` regex with `Posix`

[text results](benchmark/Output/validate_input.md)

[visual results](benchmark/Output/validate_input_visual.md)

## Show sumtype

Compare generic `show` against approach using `unpack`.

`Unpack` (from Text to String) reduces operation speed in 6-7 times.

[text results](benchmark/Output/unpack_overhead.md)

[visual results](benchmark/Output/unpack_overhead_visual.md)

## FromList to Set

Compare overheads of using `fromList` which nub duplicates.
And traversinf with predicate.

`fromList` decrease performance to 14-30 times.

[text results](benchmark/Output/from_list.md)

[visual results](benchmark/Output/from_list.md)


