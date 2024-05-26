import { homeTabControl, ResourceManager, RouterConstants } from '@hm/basic/Index'
import { router } from '@kit.ArkUI'
import { MessageCountData } from '../model/HomeModel'

export enum Pos {
  x = 'x',
  y = 'y'
}

class MessageCount {
  count: number = 0
}

/**
 * 消息item
 * @param title 标题
 * @param icon 图标地址
 * @param messageCount 消息数
 * @param index 序号
 */
@Builder
export function msgItem(title: string, icon: Resource | string, messageCount: MessageCount, index: number) {
  Column() {
    Badge({
      count: messageCount.count,
      position: BadgePosition.RightTop,
      style: {
        badgeColor: '#FF6363',
        borderColor: '#fff',
        borderWidth: 2,
        badgeSize: 20
      }
    }) {
      Image(icon)
        .width(40)
        .aspectRatio(1)
        .margin({ bottom: 10 })
    }

    Text(title)
      .fontSize(ResourceManager.EC_SMALL_FS)
      .fontColor(ResourceManager.EC_MID_19)
  }
  .layoutWeight(1)
  .borderRadius(8)
  .padding({ top: 20, bottom: 23 })
  .backgroundColor(ResourceManager.EC_MID_WHITE)
  .onClick(() => {
    router.pushUrl({
      url: RouterConstants.USER_MSG_URL,
      params: {
        type: index
      }
    })
  })
}

/**
 * 模块item
 * @param title 标题
 * @param icon 图标地址
 * @param pos 方向 x-水平 y-垂直
 * @param url 路由地址
 */
@Builder
export function careItem(title: string, icon: ResourceStr, pos: Pos, url: string, bg: string = '') {
  if (pos === Pos.x) {
    // 护理工作台
    Row({ space: 10 }) {
      Image(icon)
        .width(48)
        .aspectRatio(1)
      Text(title)
        .fontColor(ResourceManager.EC_MID_19)
        .fontSize(ResourceManager.EC_NORMAL_FS)
    }
    .padding({
      top: 20,
      bottom: 23,
      left: 13,
      right: 13
    })
    // .borderRadius(8)
    // .layoutWeight(1)
    // .backgroundColor(ResourceManager.EC_MID_WHITE)
    .modStyle()
    .onClick(() => {
      if (url === '') {
        homeTabControl.homeController?.changeIndex(2)
      } else {
        router.pushUrl({
          url
        })
      }
    })
  } else {
    // 设备管理
    Column({ space: 10 }) {
      Image(icon)
        .width(40)
        .aspectRatio(1)
      Text(title)
        .fontColor(ResourceManager.EC_MID_19)
        .fontSize(ResourceManager.EC_SMALL_FS)
    }
    .padding({ top: 23, bottom: 23 })
    // .borderRadius(8)
    // .layoutWeight(1)
    // .backgroundColor(ResourceManager.EC_MID_WHITE)
    .modStyle()
    .backgroundColor(bg ? bg : '#fff')
    .onClick(() => {
      router.pushUrl({
        url
      })
    })
  }
}

// 可复用样式=>不支持导出
@Styles
function modStyle() {
  .borderRadius(8)
  .layoutWeight(1)
  .backgroundColor(ResourceManager.EC_MID_WHITE)
}