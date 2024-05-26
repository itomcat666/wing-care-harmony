import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import dayjs from 'dayjs';
import { Log } from '@abner/log';
import { RouterConstants } from '@hm/basic/Index';

dayjs.locale('zh-cn')

Log.init({
  tag: 'ECX',
  domain: 0xEC00,
  close: false,
  isHilog: true,
  showLogLocation: true,
  logSize: 200
})

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Log.info('Ability onCreate')
  }

  onDestroy(): void {
    Log.info('Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Log.info('Ability onWindowStageCreate')

    windowStage.loadContent(RouterConstants.SPLASH_URL, (err, data) => {
      if (err.code) {
        Log.error(`Failed to load the content. Cause: ${JSON.stringify(err) ?? ''}`)
        return;
      }
      Log.info(`Succeeded in loading the content. Data: ${JSON.stringify(data) ?? ''}`)
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Log.info('Ability onWindowStageDestroy')
  }

  onForeground(): void {
    // Ability has brought to foreground
    Log.info('Ability onForeground')
  }

  onBackground(): void {
    // Ability has back to background
    Log.info('Ability onBackground')
  }
}
