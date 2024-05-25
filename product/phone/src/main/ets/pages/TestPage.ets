import { request } from '@hm/basic'
import { Log } from '@abner/log'

interface UserData {
  id: string,
  username: string,
  nickName: string,
  avatar: string | null
}

@Entry
@Component
struct TestPage {
  aboutToAppear(): void {
    this.getUser()
  }

  async getUser() {
    const res = await request<UserData>({ url: '/employee/user' })
    Log.info(res)
  }

  build() {
    Column({ space: 20 }) {
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}