import { Home } from '@ec/home'
import { TabBarItem, tabBarList } from '../model'
import { windowManager } from '@itheima/wing-care'
import { homeTabControl } from '@hm/basic/Index'

windowManager.enableFullScreen()

@Entry
@Component
struct Index {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0
  @State
  activeIndex: number = 0
  tabBars: TabBarItem[] = tabBarList

  @Builder
  TabBarBuilder(item: TabBarItem, index: number) {
    Column() {
      // 图标
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width(24)
        .aspectRatio(1)
      // 文字
      Text(item.label)
        .fontSize(10)
        .margin({ top: 4 })
        .lineHeight(12)
        .fontColor(this.activeIndex === index ? '#000' : '#aaa')
    }
  }

  aboutToAppear(): void {
    // 每次初始化新的 tabControl 实例，避免 tab 点击失效问题
    homeTabControl.homeController = new TabsController()
  }

  build() {
    Tabs({
      index: $$this.activeIndex,
      controller: homeTabControl.homeController
    }) {
      ForEach(this.tabBars, (item: TabBarItem, index: number) => {
        TabContent() {
          // tab 内容=》切换子组件
          if (index === 0) {
            Home()
          }
          // else if (index === 1) Duty()
          // else if (index === 2) Stage()
          // else Mine()
        }
        .tabBar(this.TabBarBuilder(item, index))
      })
    }
    .barPosition(BarPosition.End)
    .barBackgroundColor('#fff')
    .padding({ bottom: this.bottomHeight })
  }
}