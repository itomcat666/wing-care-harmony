import { RouterConstants, userStore } from '@hm/basic/Index'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct SplashPage {
  @State count: number = 5 // 倒计时
  timerId: number = -1 // 定时器id

  aboutToAppear(): void {
    this.countdown()
  }

  countdown() {
    this.timerId = setInterval(() => {
      this.count--
      if (this.count === 0) {
        clearInterval(this.timerId)
        const store = userStore.getUser()
        router.replaceUrl({ url: store.token ? 'page/Index' : RouterConstants.LOGIN_URL })
      }
    }, 1000)
  }

  build() {
    Row() {
      Column() {
        Text('闪屏页面，倒计时：' + this.count)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}