# -*- coding: utf-8 -*-
###############################################################################
#    License, author and contributors information in:                         #
#    __openerp__.py file at the root folder of this module.                   #
###############################################################################

from odoo import models, fields, api
from odoo.tools.translate import _
from logging import getLogger


_logger = getLogger(__name__)


WIZARD_STATES = [
    ('step1', 'Tests'),
    ('step2', 'Questions'),
]


# pylint: disable=locally-disabled, w0212
class ChangeOwnerWizard(models.TransientModel):
    """ This wizard allows managers to change questions and tests owner

    Fields:
      name (Char): Human readable name which will identify each record.

    """

    _name = 'academy.tests.change.owner.wizard'
    _description = u'Change owner wizard'

    _rec_name = 'id'
    _order = 'id ASC'


    question_ids = fields.Many2many(
        string='Questions',
        required=False,
        readonly=False,
        index=False,
        default=lambda self: self.default_question_ids(),
        help='Choose tests who owner will be changed',
        comodel_name='academy.tests.question',
        relation='academy_tests_question_change_owner_wizard_rel',
        column1='change_owner_wizard_id',
        column2='question_id',
        domain=[],
        context={},
        limit=None
    )

    test_ids = fields.Many2many(
        string='Tests',
        required=False,
        readonly=False,
        index=False,
        default=lambda self: self.default_test_ids(),
        help='Choose tests who owner will be changed',
        comodel_name='academy.tests.test',
        relation='academy_tests_test_change_owner_wizard_rel',
        column1='change_owner_wizard_id',
        column2='test_id',
        domain=[],
        context={},
        limit=None
    )

    owner_id = fields.Many2one(
        string='Owner',
        required=True,
        readonly=False,
        index=False,
        default=lambda self: self.default_owner_id(),
        help='Choose new owner',
        comodel_name='res.users',
        domain=[],
        context={},
        ondelete='cascade',
        auto_join=False
    )

    state = fields.Selection(
        string='State',
        required=False,
        readonly=False,
        index=False,
        default=lambda self: self.default_state(),
        help='Current wizard step',
        selection=WIZARD_STATES
    )


    def default_question_ids(self):
        """ It computes default question list loading all has been selected
        before wizard opening
        """

        ids = []
        model = self.env.context.get('active_model', None)

        if model == 'academy.tests.question':
            ids = self.env.context.get('active_ids', [])

        return [(6, None, ids)] if ids else False


    def default_test_ids(self):
        """ It computes default question list loading all has been selected
        before wizard opening
        """

        ids = []
        model = self.env.context.get('active_model', None)

        if model == 'academy.tests.test':
            ids = self.env.context.get('active_ids', [])

        return [(6, None, ids)] if ids else False


    def default_owner_id(self):
        return self.env.context.get('uid', None)


    def default_state(self):
        model = self.env.context.get('active_model', None)

        return WIZARD_STATES[1 if model == 'academy.tests.question' else 0][0]


    def update_targets(self):
        self.question_ids.owner_id = self.owner_id
        self.test_ids.owner_id = self.owner_id
