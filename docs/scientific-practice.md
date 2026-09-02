# Scientific practice for aligned biological displays

## Identity first

Trees and matrices often arrive from different tools. Confirm exact identifier
sets, uniqueness, and order before attaching traits or concatenating panels.
The package deliberately rejects partial and duplicated matches.

## Make transformations visible

State whether cells contain presence/absence, counts, relative abundance, CLR
coordinates, log expression, row z-scores, correlations, or variant categories.
The same palette can make those quantities look deceptively interchangeable.

## Separate inference from display

ggtree visualizes topology produced upstream; ComplexHeatmap clusters values
according to user-selected transformations and distances. Neither drawing step
establishes evolutionary causality, differential abundance, clinical action,
or statistically significant subtypes.
