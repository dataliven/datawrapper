
root._ = require 'underscore'
root.$ = require 'jquery'
vows = require 'vows'
assert = require 'assert'

dw = require '../dw.js'

women_in_parl = 'Party	Women	Men	Total\n
CDU/CSU	45	192	237\n
SPD	57	89	146\n
FDP	24	69	93\n
LINKE	42	34	76\n
GRÜNE	36	32	68\n'

vows
    .describe('Reading different CSV datasets')

    .addBatch

        'The csv "women-in-parliament"':
            topic: dw.datasource.delimited
                csv: women_in_parl

            'when loaded as dataset':
                topic: (src) ->
                    src.dataset().done @callback
                    return

                'has four columns': (dataset, f) ->
                    assert.equal dataset.numColumns(), 4

                'has five rows': (dataset, f) ->
                    assert.equal dataset.numRows(), 5


    .export module
