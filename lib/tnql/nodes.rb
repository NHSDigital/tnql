# These file contain custom mixins for treetop
# nodes that enable them to generate meta_data_items, etc.

# Treetop documentation seems to be out of date;
# it says to create subclasses of nodes. However,
# treetop 1.4.10 expects to extend the node with
# the specified <MODULE> from the grammar.

require 'tnql/treetop/extensions'
require 'tnql/constants'

require 'tnql/nodes/age'
require 'tnql/nodes/batch_types'
require 'tnql/nodes/dates'
require 'tnql/nodes/diagnosis'
require 'tnql/nodes/e_base_records'
require 'tnql/nodes/main'
require 'tnql/nodes/patient'
require 'tnql/nodes/provider'
require 'tnql/nodes/registration_status'
require 'tnql/nodes/registry'
require 'tnql/nodes/staging'
require 'tnql/nodes/treatment'
require 'tnql/nodes/tumour_type'
require 'tnql/nodes/vital_status'
