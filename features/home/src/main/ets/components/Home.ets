import { ResourceManager, RouterConstants } from '@hm/basic/Index'
import { getMessageCountApi } from '../api/MsgApi'
import { MessageCountData } from '../model/HomeModel'
import { router } from '@kit.ArkUI'
import { careItem, msgItem, Pos } from '../style'

@Component
export struct Home {
  @State elderAlertMsgCount: number = 0 // 任务提醒消息数量
  @State nursingTaskMsgCount: number = 0 // 老人报警消息数量

  aboutToAppear(): void {
    this.getMessageCount()
  }

  async getMessageCount() {
    const data = await getMessageCountApi()
    this.elderAlertMsgCount = data.elderAlertMsgCount
    this.nursingTaskMsgCount = data.nursingTaskMsgCount
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 25 }) {
        Column() {
          // 1.1 广告图
          Image($r('app.media.img_banner'))
            .width('100%')
            .aspectRatio(1.32)

          //  1.2 消息提醒
          Column() {
            Row({ space: 10 }) {
              msgItem('老人报警消息', $r("app.media.ic_home_jkbj"), { count: this.elderAlertMsgCount }, 0)
              msgItem('任务提醒消息', $r("app.media.ic_home_rwtx"), { count: this.nursingTaskMsgCount }, 1)
            }
          }
          .margin({
            top: -50,
            left: ResourceManager.EC_CONTENT_SPACE,
            right: ResourceManager.EC_CONTENT_SPACE,
          })
        }
        .width('100%')

        Column({ space: 25 }) {
          //  1.3 护理工作台
          Column() {
            // 标题
            Text('护理工作台')
              .fontColor(ResourceManager.EC_MID_19)
              .fontSize(ResourceManager.EC_MODULE_TITLE_FS)
              .fontWeight(500)
              .margin({ bottom: 13 })
            // 内容
            Row({ space: 10 }) {
              careItem('护理任务', $r('app.media.icon_home_hlrw'), Pos.x, '')
              careItem('护理记录', $r('app.media.icon_home_hljl'), Pos.x, RouterConstants.STAGE_NURSE_RECORDS_URL)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // //  1.4 设备管理
          // Column() {
          //   // 标题
          //   Text('设备管理')
          //     .fontColor(ResourceManager.EC_MID_19)
          //     .fontSize(ResourceManager.EC_MODULE_TITLE_FS)
          //     .fontWeight(500)
          //     .margin({ bottom: 13 })
          //   // 内容
          //   Row({ space: 10 }) {
          //     // careItem('设备安装', $r('app.media.icon_home_sbaz'), Pos.y, 'pages/device/SetupDevicePage')
          //     // careItem('设备绑定', $r('app.media.icon_home_sbkz'), Pos.y, 'pages/device/BindDevicePage')
          //     // careItem('我的设备', $r('app.media.icon_home_wdsb'), Pos.y, 'pages/device/MyDevicePage')
          //     // careItem('报警设备', $r('app.media.icon_home_bjsb'), Pos.y, 'pages/device/AlarmDevicePage')
          //     DeviceManager()
          //
          //   }
          //   .width('100%')
          //   .justifyContent(FlexAlign.SpaceBetween)
          //
          // }
          // .width('100%')
          // .alignItems(HorizontalAlign.Start)

        }
        .width('100%')
        .padding({ left: 15, right: 15 })

      }
      .width('100%')
      .height('100%')

      // 2. 服务口号
      Row() {
        Image($r('app.media.img_home_kouhao'))
          .width(211)
          .height(15)
      }
      .margin({ bottom: 28 })
      .onClick(() => router.pushUrl({ url: 'pages/test/TestPage' }))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ResourceManager.EC_MID_BG)
  }
}
