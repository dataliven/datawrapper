
root._ = require 'underscore'
root.$ = require 'jquery'
vows = require 'vows'
assert = require 'assert'

dw = require '../dw.js'

_types = (c) -> c.type()


vows
    .describe('Reading different CSV datasets')

    .addBatch


        'The tsv "women-in-parliament"':
            topic: dw.datasource.delimited
                csv: 'Party	Women	Men	Total\nCDU/CSU	45	192	237\nSPD	57	89	146\nFDP	24	69	93\nLINKE	42	34	76\nGRÜNE	36	32	68\n'

            'when loaded as dataset':
                topic: (src) ->
                    src.dataset().done @callback
                    return

                'has four columns': (dataset, f) ->
                    assert.equal dataset.numColumns(), 4

                'has five rows': (dataset, f) ->
                    assert.equal dataset.numRows(), 5

                'has correct column types': (dataset, f) ->
                    assert.deepEqual _.map(dataset.columns(), _types), ['text', 'number', 'number', 'number']


        'The csv "german-debt"':
            topic: dw.datasource.delimited
                transpose: true
                csv: '"","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"\n"New debt in Bio.","14,3","11,5","34,1","44","17,3","34,8","19,6","14,6","10,3","1,1"\n'

            'when loaded as dataset':
                topic: (src) ->
                    src.dataset().done @callback
                    return

                'has two columns': (dataset, f) ->
                    assert.equal dataset.numColumns(), 2

                'has ten rows': (dataset, f) ->
                    assert.equal dataset.numRows(), 10

                'has correct column types': (dataset, f) ->
                    assert.deepEqual _.map(dataset.columns(), _types), ['date', 'number']

                'was correctly parsed': (dataset, f) ->
                    assert.equal dataset.column(1).val(0), 14.3

    .export module