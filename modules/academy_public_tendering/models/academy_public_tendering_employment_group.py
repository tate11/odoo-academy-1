# -*- coding: utf-8 -*-
###############################################################################
#    License, author and contributors information in:                         #
#    __openerp__.py file at the root folder of this module.                   #
###############################################################################

from odoo import models, fields, api, api
from odoo.tools.translate import _
from logging import getLogger


_logger = getLogger(__name__)


class AptGroup(models.Model):
    """ Group for vacancy position

    Fields:
      name (Char): Human readable name which will identify each record.

    """

    _name = 'academy.public.tendering.employment.group'
    _description = u'Public tendering, employment group of vacancy position'

    _rec_name = 'name'
    _order = 'name ASC'

    name = fields.Char(
        string='Name',
        required=True,
        readonly=False,
        index=True,
        default=None,
        help='Name for this group',
        size=255,
        translate=True
    )

    description = fields.Text(
        string='Description',
        required=False,
        readonly=False,
        index=False,
        default=None,
        help='Something about this group',
        translate=True
    )

    active = fields.Boolean(
        string='Active',
        required=False,
        readonly=False,
        index=False,
        default=True,
        help=('If the active field is set to false, it will allow you '
              'to hide record without removing it.')
    )
