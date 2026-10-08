# 旅游路书

多趟行程共用本仓库：每趟攻略各占 `guides/<slug>/`，入口是该目录下的 `index.html`。根目录不再放目录页。

## 目录约定

```
travel/
├── README.md                           # 本说明
└── guides/
    └── <slug>/                         # 英文 slug，如 2026-guangxi-national-day
        └── index.html                  # 该趟完整路书单页（入口）
```

- **入口**：`guides/<slug>/index.html`（一趟行程的完整静态页：Leaflet CDN、高德关键词导航等）。
- **根目录**：只保留 README 等说明，不放目录首页。
- **slug**：只用英文小写、数字、连字符（`YYYY-place-occasion`）。
- **新攻略**：只新增 `guides/<slug>/` 子目录，无需改根目录。

---

## 新增一趟

1. **建目录**：`guides/<slug>/`，复制现有某趟的 `index.html` 作模版（或从零按下方大纲写）。
2. **改内容**：`<title>` / `<h1>`、日期、每日行程、地图点、住宿、费用等全部换成新行程。
3. **本地打开**：`open guides/<slug>/index.html`，确认相对路径与地图正常。

### POI / 导航规则（与现版脚本一致）

- **店名/地名明确** → `data-poi='{"name":"…","search":"高德关键词","city":"城市"}'`，挂高德 search
- **隐私住址 / 家** → 笼统写（市·区或镇一级），**不挂回家导航**，**不写精确门牌**
- **无店名、不确定** → `<p class="no-nav">…不链</p>`，不编地址
- **禁止假坐标**；地图点仅作方位示意，导航一律走关键词搜索

---

## 单趟模版大纲（与 TOC 对齐）

| 区块 | `id` | 内容要点 |
|------|------|----------|
| 行程概览 | `#overview` | 天数/主题、统计数字、总路线 strip |
| 行程路线图 | `#route-map` | Leaflet + OSM 方位示意（非导航精确坐标） |
| 驾车导航段 | `#map` | 分段起终点列表，由脚本生成导航按钮 |
| 每日行程 | `#dMMDD`… | 见下 |
| 物品清单 | `#packing` | 证件/车、衣物、防晒徒步、日用/药 |
| 行前预约 | `#booking` | 住宿、向导/报团、网红店等 checklist |
| 住宿速查 | `#stay` | 夜 / 酒店 / 备注（仅明确店名） |
| 费用明细 | `#cost` | 个人账分项 + 合计 |
| 理想版 vs 实际 | `#ideal` | 实际走过 ↔ 更完美抄作业版 |
| 注意事项 | `#tips` | 亲测路况、穿衣、订房等 |

### 每日行程结构

每个 `section.day`：

1. **day-header**：日期 + 当日主题一句话
2. **timeline**（可选）：当日时间轴（约，亲测估算）
3. **leg / stops**：分段景点或停靠点
4. **choice-row**（可选）：二选一并排（如傍晚日落 / 爬山 / 下山后去向）

---

## 写新路书前尽量给齐

- [ ] 起止日期、过夜城市/晚数
- [ ] 每日主题与大致时间轴（可标「约」）
- [ ] 明确店名/景点名（可搜高德的才链）
- [ ] 住宿：哪一晚、店全名、备注（信号/餐食等）
- [ ] 费用分项（个人账即可）
- [ ] 路况亲测、穿衣/补给经验
- [ ] 二选一场景（A/B 及最终选了哪边）
- [ ] 理想版 vs 实际：哪些没做成、下次怎么改
- [ ] 行前必须预约的项

不必提供：精确门牌、回家导航终点、猜的坐标。

---

## 本地打开

```bash
open guides/2026-guangxi-national-day/index.html
```

Leaflet / 地图瓦片走 CDN，子目录相对路径无需额外调整。

---

## 在线分享（GitHub Pages）

仓库：https://github.com/Do3956/travel

启用 GitHub Pages（Settings → Pages → Deploy from a branch = `master`，folder = `/`）后分享：

- 目录页：https://do3956.github.io/travel/
- 单趟示例：https://do3956.github.io/travel/guides/2026-guangxi-national-day/
