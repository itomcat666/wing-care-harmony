import { Log } from '@abner/log'
import { authentication } from '@kit.AccountKit'
import { util } from '@kit.ArkTS'
import { loginApi, userStore } from '@hm/basic/Index'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct LoginPage {
  // 手机号快速验证
  getCode() {
    // 创建授权请求，并设置参数
    const authRequest = new authentication.HuaweiIDProvider().createAuthorizationWithHuaweiIDRequest()
    // 获取手机号需要传如下scope，传参数之前需要先申请对应scope权限,才能返回对应数据
    authRequest.scopes = ['phone']
    // 获取code需传如下permission
    authRequest.permissions = ['serviceauthcode']
    // forceAuthorization参数用来控制是否拉起授权页面
    authRequest.forceAuthorization = true
    // 用于防跨站点请求伪造，非空字符串即可
    authRequest.state = util.generateRandomUUID();
    try {
      const controller = new authentication.AuthenticationController(getContext())
      // 执行请求
      controller.executeRequest(authRequest, async (err, data) => {
        if (err) {
          return Log.error(`auth fail, error: ${JSON.stringify(err)}`)
        }
        const authorizationWithHuaweiIDResponse = data as authentication.AuthorizationWithHuaweiIDResponse
        const state = authorizationWithHuaweiIDResponse.state
        if (state != undefined && authRequest.state != state) {
          return Log.error(`auth fail,The state is different: ${JSON.stringify(authorizationWithHuaweiIDResponse)}`)
        }
        Log.debug(`auth success: ${JSON.stringify(authorizationWithHuaweiIDResponse)}`)
        let authorizationWithHuaweiIDCredential = authorizationWithHuaweiIDResponse.data!
        let code = authorizationWithHuaweiIDCredential.authorizationCode
        // TODO: 开发者处理code
        Log.info('授权code：' + code)
        // 1. 调用 api 登录，接口有问题
        // const token = await loginApi({ code: code! })
        const token =
          'eyJhbGciOiJIUzI1NiJ9.eyJjdXJyZW50VXNlciI6IntcInVzZXJuYW1lXCI6XCJobHpnQHFxLmNvbVwiLFwicGFzc3dvcmRcIjpcIlwiLFwibmlja05hbWVcIjpcIuaKpOeQhue7hOS4u-euoVwiLFwiZW1haWxcIjpcImhsemdAcXEuY29tXCIsXCJyZWFsTmFtZVwiOlwi5oqk55CG57uE5Li7566hXCIsXCJtb2JpbGVcIjpcIlwiLFwic2V4XCI6XCJcIixcImRlcHROb1wiOlwiMTAwMDAxMDA1MDAwMDAwXCIsXCJwb3N0Tm9cIjpcIjEwMDAwMTAwNTAwMjAwMFwiLFwiaWRcIjoxNjY4NTIyMjgwODUxOTUxNjE3LFwiY3JlYXRlVGltZVwiOjE2OTU3MTAwOTcwMDAsXCJ1cGRhdGVUaW1lXCI6MTY5NTcxMDA5NzAwMCxcImNyZWF0ZUJ5XCI6MTY3MTQwMzI1NjUxOTA3ODEzOH0iLCJleHAiOjE0NjY0ODUzMzkyfQ.AwoGeu-mp0QSSsQnDOhQluAPdbFM7Ygll86fk6l3DIA'
        // 2. 存储 token
        await userStore.setUser({ token })
        promptAction.showToast({ message: '登录成功' })
        // 3. 跳转页面
        router.replaceUrl({ url: 'pages/Index' })
      })
    } catch (error) {
      Log.error(`auth failed: ${JSON.stringify(error)}`)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // app 信息
        Column() {
          Image($r("app.media.pic_login_icon"))
            .width(124)
            .height(76)
            .margin({ bottom: 20 })
          Text() {
            Span('翼康养老')
              .fontColor('#000')
              .fontSize(24)
              .fontWeight(700)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#fff')

        Button({ stateEffect: true }) {
          Row({ space: 6.5 }) {
            // Image(ResManager.IC_HUAWEI)
            //   .width(24)
            //   .aspectRatio(1)
            Text('华为登录')
              .fontColor('#fff')
              .fontWeight(500)
            // .fontSize(ResManager.EC_MODULE_TITLE_FS)
          }
        }
        .margin({ top: 150 })
        .width(250)
        .height(40)
        // .backgroundColor(ResManager.EC_MAIN_COLOR)
        .onClick(() => this.getCode())
      }
    }
    .width('100%')
    .height('100%')
  }
}