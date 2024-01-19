#include "core\_definitions.dm"
#include "core\core.dm"
#include "core\datum.dm"
#include "core\tgs_version.dm"

#ifdef TGS_V3_API
#include "v3210\api.dm"
#include "v3210\commands.dm"
#endif

#include "v4\api.dm"
#include "v4\commands.dm"

#include "v5\_defines.dm"
#include "v5\api.dm"
#include "v5\api_vgs.dm" // VOREStation Edit - Include here so it has access to v5 defines
#include "v5\bridge.dm"
#include "v5\chunking.dm"
#include "v5\commands.dm"
#include "v5\chat_commands.dm" // YW Edit: technically not a YW edit but leaving it here considering the dmapi does not includ this by default
#include "v5\serializers.dm"
#include "v5\topic.dm"
#include "v5\undefs.dm"
