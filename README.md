# 旅游路书

多趟行程共用本仓库：每趟攻略各占 `guides/<slug>/`，入口是该目录下的 `index.html`。根目录不放目录页（若有 `index.html`，仅作跳转/说明，不当作品牌首页）。

**规范样例（以用户反馈定稿为准）**：[`guides/2026-guangxi-national-day/index.html`](guides/2026-guangxi-national-day/index.html)

写新路书或改旧路书时，按本文 checklist 执行，避免再返工。

---

## 目录约定

```
travel/
├── README.md                           # 本说明（作者 / AI 规范）
├── .github/workflows/…                 # Cloudflare Pages 自动部署
└── guides/
    └── <slug>/                         # 英文 slug，如 2026-guangxi-national-day
        └── index.html                  # 该趟完整路书单页（入口）
```

- **入口**：`guides/<slug>/index.html`（单页静态：Leaflet CDN、高德关键词搜索导航等）。
- **根目录**：只保留 README 等说明，不放攻略正文。
- **slug**：英文小写、数字、连字符（`YYYY-place-occasion`）。
- **新攻略**：只新增 `guides/<slug>/`，无需改根目录逻辑。

### 隐私

- 家 / 私人住址：页面上只写到 **市·镇** 一级（本仓库惯例：**中山南朗**，或同等笼统地名）。
- **不写精确门牌**，**不挂回家导航**，不把私人坐标当 POI。

---

## 新增一趟（最短路径）

1. 建 `guides/<slug>/`，复制规范样例 `index.html` 再改（优先复制，少从零发明结构）。
2. 改 `<title>` / `<h1>`、日期、每日行程、地图点、住宿、费用、物品清单。
3. 本地打开：`open guides/<slug>/index.html`，确认时间轴不折行、导航图标、概览地图瓦片正常。
4. 对照下方 **写作 checklist** 自检一遍再提交。

---

## 写作 checklist（必须遵守）

### 结构与部署

- [ ] 路径为 `guides/<slug>/index.html`
- [ ] 家只写笼统地名（如中山南朗），无门牌、无回家导航
- [ ] 部署走 **GitHub → Cloudflare Pages**（push `master` 触发 Actions）；见文末「在线分享」
- [ ] Secret 用 **API Token**（Bearer），**不要** Global API Key（常见前缀 `cfk_`，CI 会判错）
- [ ] Token 需含 **Pages** 相关权限（可用 Edit Cloudflare Workers / Pages 模板）
- [ ] 另配 `CLOUDFLARE_ACCOUNT_ID` Secret；本项目生产部署时 wrangler 使用 `--branch=main`（Git 生产分支是 `master`，CF Pages 生产分支名是 `main`）

### 导航 UX

- [ ] 导航入口是站点标题旁的 **小图标**（`.nav-icon`），不要大块按钮堆叠
- [ ] **仅有明确店名 / 场馆名** 的点才挂高德 **搜索** 链接（`data-poi` + `search`）
- [ ] 无确定店名 → `no-nav` / 不挂链接；**不要编地址**
- [ ] **不要**在注意事项等处加图例句，例如：「导航：仅有明确店名的点挂搜索按钮…」
- [ ] 展示标题用 **真实目的地称呼**（例：`马山县内感屯·星空洞` / `马山 · 星空洞`），不要把「只能搜到的权宜 POI 名」当成标题；`search` 关键词可与标题不同（搜得到即可）
- [ ] 站点主操作优先 **关键词搜索到点**（与其他停靠点一致）；不要把坐标「路线图 / 导航」当成默认主入口；概览 Leaflet 路线图是另一块（`#route-map`）
- [ ] 概览地图瓦片用 **高德 / 国内可达**（如 `wprd0{s}.is.autonavi.com/appmaptile…`）；**不要只用 OSM**（国内常空白）

### 文案语气

- [ ] **禁止元话语**：不要写「你明确告知的」「用户说的」「未告知」等作者备注口吻
- [ ] 酒店 / 事实直接陈述；未知写 **待定** / **自行规划**
- [ ] 时间轴左侧时间列够宽（约 `9rem`）+ `white-space: nowrap`，避免 `约 08:00–09:30` 折行难看

### 山线 / 探洞默认装备（有徒步、陡坡、洞穴时）

- [ ] **中长筒排汗袜**（勿纯棉）；可选再带一双旧袜套鞋外，下山增阻、少脏鞋
- [ ] **登山鞋 / 防滑鞋，鞋头偏硬**（勿运动鞋，易撞石伤趾）
- [ ] 陡坡提示：**手套**；陡线带 **登山杖**
- [ ] 相关时列入：双肩小包、水泡贴、手机防水袋
- [ ] 已知停车技巧写进正文（例：水库附近早点停，登山口易满位）

### 费用

- [ ] 按类型分组（交通 / 住宿 / 餐饮 / 门票…），每组有 **小计**
- [ ] 开篇说明 **账单含谁**（例：仅记本人账、朋友未计入；三人行约两人份等）

---

## POI / 导航规则（与脚本一致）

| 情况 | 写法 |
|------|------|
| 店名/地名明确 | `data-poi='{"name":"…","search":"高德关键词","city":"城市"}'` → 标题旁搜索图标 |
| 标题与搜索词不同 | `name` / 标题写真实称呼；`search` 写能搜到的词（如标题「星空洞」，搜「马山县内感屯」） |
| 隐私住址 / 家 | 笼统写，**不挂导航** |
| 无店名、不确定 | `<p class="no-nav">店名待定 · 不链导航</p>`，不编地址 |
| 禁止 | 假坐标当精确导航；把坐标路线图当作站点默认主按钮；页面加「仅明确店名才挂按钮」类图例 |

---

## 单趟 HTML 大纲（与 TOC 对齐）

复制样例后按这些 `id` 填内容即可。

| 区块 | `id` | 要点 |
|------|------|------|
| 行程概览 | `#overview` | 天数/主题、统计、总路线 strip；家用笼统地名 |
| 行程路线图 | `#route-map` | Leaflet + **高德底图**；方位示意，非精确导航 |
| 驾车导航段 | `#map` | 分段起终点；有明确终点才生成搜索按钮 |
| 每日行程 | `#dMMDD`… | 见下 |
| 物品清单 | `#packing` | 证件/车、衣物、防晒徒步、日用/药；山线套用默认装备 |
| 行前预约 | `#booking` | 住宿、向导/报团、网红店 checklist |
| 住宿速查 | `#stay` | 夜 / 酒店 / 备注；仅已知店名，待定不编 |
| 费用明细 | `#cost` | 分类 + 小计 + 说明账单归属 |
| 理想版 vs 实际 | `#ideal` | 实际走过 ↔ 更完美抄作业版 |
| 注意事项 | `#tips` | 路况、穿衣、订房；**不加导航图例句** |

### 每日行程结构

每个 `section.day`：

1. **day-header**：日期 + 当日主题一句话  
2. **timeline**（可选）：时间轴；`.t` 宽列 + nowrap  
3. **leg / stops**：停靠点；`h3.stop-name` + 可选 `.nav-actions` / `data-poi`  
4. **choice-row**（可选）：二选一并排（日落 / 爬山 / 下山后去向）

### 新页自检（HTML / CSS / JS）

```text
□ <title>、<h1>、meta description 已换行程
□ 家：中山南朗（或笼统）且无导航
□ 时间轴 .timeline .t：nowrap + 足够列宽
□ 有 data-poi 的点：标题旁小图标，主链为高德 search
□ 无店名：no-nav，文案用「待定 / 自行规划」
□ #route-map：高德 tileLayer，非纯 OSM
□ #cost：分类小计 + 账单归属说明
□ #packing：山线时含排汗中筒袜、硬头登山鞋、手套/杖等
□ 全文无「你明确告知」「用户说的」「未告知」等元话语
□ 注意事项无「导航：仅有明确店名…」图例
```

---

## 写新路书前尽量给齐（向用户要的信息）

- [ ] 起止日期、过夜城市/晚数  
- [ ] 每日主题与大致时间轴（可标「约」）  
- [ ] 明确店名/景点名（能搜高德的才链）  
- [ ] 住宿：哪一晚、店全名、备注（信号/餐食等）  
- [ ] 费用分项 + **谁的账**  
- [ ] 路况亲测、穿衣/补给/停车经验  
- [ ] 二选一场景（A/B 及最终选了哪边）  
- [ ] 理想版 vs 实际  
- [ ] 行前必须预约的项  

不必提供：精确门牌、回家导航终点、猜的坐标。

---

## 本地打开

```bash
open guides/2026-guangxi-national-day/index.html
```

Leaflet / 地图瓦片走 CDN；子目录相对路径无需额外调整。改完用浏览器硬刷新确认地图与图标。

---

## 在线分享

仓库：https://github.com/Do3956/travel

**推荐（Cloudflare Pages，国内相对稳）：**

- 站点：https://travel-aft.pages.dev/
- 单趟示例：https://travel-aft.pages.dev/guides/2026-guangxi-national-day/

push 到 **`master`** 后由 GitHub Actions 自动部署（见 `.github/workflows/deploy-cloudflare-pages.yml`）。  
注意：Git 分支是 `master`，wrangler 部署参数使用 `--branch=main`（对应 Cloudflare Pages 的生产分支名）。

**备用（GitHub Pages）：**

- https://do3956.github.io/travel/
- https://do3956.github.io/travel/guides/2026-guangxi-national-day/

### 配置自动部署（只需一次）

1. Cloudflare → [API Tokens](https://dash.cloudflare.com/profile/api-tokens) → Create Token  
   - 用 **Edit Cloudflare Workers** 模板（含 Pages），或自建权限含 **Account → Cloudflare Pages → Edit**  
   - **不要**用 Global API Key（`cfk_` / 纯 hex 长串当 Bearer 会失败）
2. GitHub 仓库 → Settings → Secrets and variables → Actions → New repository secret：  
   - `CLOUDFLARE_API_TOKEN` = 上一步的 **API Token**  
   - `CLOUDFLARE_ACCOUNT_ID` = `a3310520f43804d618fbca58898b2b1d`  
3. 以后本地改完 `git push origin master` 即可更新站点
