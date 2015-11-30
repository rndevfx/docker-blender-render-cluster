import os
import bpy.ops
import logging

logger = logging.getLogger()
logger.setLevel(20)

renderMode = os.getenv('RENDER_MODE', False)

masterIp = os.getenv('MASTER_PORT_8000_TCP_ADDR', False)

if masterIp == False:
    masterIp = os.getenv('MASTER_IP', '127.0.0.1')

if renderMode == False:
    logger.warning('No RENDER_MODE environment variable detected. Set default to SLAVE')
    renderMode = 'SLAVE'

logger.info("Set render mode to: " + renderMode)

bpy.ops.wm.addon_enable(module="netrender")
bpy.context.scene.render.engine = 'NET_RENDER'

if renderMode == 'MASTER':
    bpy.context.scene.network_render.mode = 'RENDER_MASTER'

if renderMode == 'SLAVE':
    bpy.context.scene.network_render.mode = 'RENDER_SLAVE'
    bpy.context.scene.network_render.server_address = masterIp

bpy.ops.render.netclientstart()
