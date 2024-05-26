export class TabBarItem {
  defaultIcon: string | Resource = ''
  activeIcon: string | Resource = ''
  label: string = ''
}

export const tabBarList: TabBarItem[] = [
  {
    defaultIcon: $r('app.media.icon_tab_home_nor'),
    activeIcon: $r('app.media.icon_tab_home_sel'),
    label: '首页'
  },
  {
    defaultIcon: $r('app.media.icon_tab_laoren_nor'),
    activeIcon: $r('app.media.icon_tab_laoren_sel'),
    label: '负责老人'
  },
  {
    defaultIcon: $r('app.media.icon_tab_hl_nor'),
    activeIcon: $r('app.media.icon_tab_hl_sel'),
    label: '护理工作台'
  },
  {
    defaultIcon: $r('app.media.icon_tab_mine_nor'),
    activeIcon: $r('app.media.icon_tab_mine_sel'),
    label: '我的'
  }
]