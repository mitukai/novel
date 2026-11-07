[_tb_system_call storage=system/_preview.ks ]

[mask time=10]
[mask_off time=10]
[cm  ]
[bg  storage="room.jpg"  time="1000"  ]
[tb_show_message_window  ]
[tb_eval  exp="f.day=1"  name="day"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.weekday=3"  name="weekday"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
*next_day

[jump  storage="scene1.ks"  target="*reset_weekday"  cond="f.weekday==7"  ]
[jump  storage="scene1.ks"  target="*after_reset"  ]
*reset_weekday

[tb_eval  exp="f.weekday=0"  name="weekday"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
*after_reset

[tb_start_tyrano_code]

[if exp="f.weekday == 0"]
[eval exp="f.weekday_name = '日'"]
[elsif exp="f.weekday == 1"]
[eval exp="f.weekday_name = '月'"]
[elsif exp="f.weekday == 2"]
[eval exp="f.weekday_name = '火'"]
[elsif exp="f.weekday == 3"]
[eval exp="f.weekday_name = '水'"]
[elsif exp="f.weekday == 4"]
[eval exp="f.weekday_name = '木'"]
[elsif exp="f.weekday == 5"]
[eval exp="f.weekday_name = '金'"]
[elsif exp="f.weekday == 6"]
[eval exp="f.weekday_name = '土'"]
[endif]

[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[layopt layer=0 visible=true]
[freeimage layer=0]
[ptext layer=0 x=1000 y=20 text="&'9月' + f.day + '日（' + f.weekday_name + '）'" size=24 color=white]
[_tb_end_tyrano_code]

[jump  storage="scene1.ks"  target="*holiday"  cond="f.weekday==0"  ]
[jump  storage="scene1.ks"  target="*holiday"  cond="f.weekday==6"  ]
[jump  storage="scene1.ks"  target="*weekday"  ]
*holiday

[tb_start_text mode=1 ]
休日[p]
[_tb_end_text]

[jump  storage="scene1.ks"  target="*plus_day"  ]
*weekday

[tb_start_text mode=1 ]
平日[p]
[_tb_end_text]

[tb_eval  exp="f.period=13"  name="period"  cmd="="  op="t"  val="13"  val_2="undefined"  ]
[tb_start_tyrano_code]
[freeimage layer=1]
[layopt layer=1 visible=true]
[ptext layer=1 x=450 y=250 text="昼休み" size=40 color=white]
[wait time=1500]
[freeimage layer=1]
[_tb_end_tyrano_code]

[jump  storage="scene1.ks"  target="*tutrial_skip"  cond="f.day!=1"  ]
[tb_start_text mode=1 ]
昼休みには自由行動することができます[p]
[_tb_end_text]

*tutrial_skip

[tb_hide_message_window  ]
[tb_start_tyrano_code]
[glink text="📝 委員会に行く" target="lunch_committee" x=400 y=200 width=500]
[glink text="📚 図書館に行く" target="lunch_library" x=400 y=270 width=500]
[glink text="🗣️ 友達と会話" target="lunch_friend" x=400 y=340 width=500]
[glink text="🏫 校内を散策" target="lunch_walk" x=400 y=410 width=500]
[glink text="🛒 購買に行く" target="lunch_shop" x=400 y=480 width=500]
[s]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
*lunch_committee

[cm]
[ptext layer=1 x=400 y=250 text="" size=36 color=white]
[wait time=1500]
[freeimage layer=1]
[jump target="mosaic_work"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
モザイクアートを進めよう！[p]
[_tb_end_text]

[tb_start_tyrano_code]
*mosaic_work

[loadjs storage="mosaic_data.js"]

[html left=0 top=0]

<div id="mosaicRoot" style="
position:fixed;
left:30px;
top:20px;
width:calc(100vw - 60px);
height:calc(100vh - 40px);
display:flex;
flex-direction:column;
align-items:flex-start;
justify-content:flex-start;
overflow-y:auto;
color:white;
text-align:center;
">

<div style="font-size:26px; margin-bottom:15px;">
文化祭モザイクアート
</div>

<div id="mosaicMenu">
<div style="font-size:20px; margin-bottom:15px;">
制作するエリアを選んでください！
</div>

<div id="mosaicAreaButtons" style="
width:520px;
display:flex;
flex-wrap:wrap;
justify-content:center;
gap:8px;
"></div>
</div>

<div id="mosaicWork" style="display:none;">

<div id="mosaicStatus" style="
font-size:19px;
margin-bottom:12px;
">
色を選んでマスをクリックしてください！
</div>

<canvas id="mosaicCanvas" width="640" height="320"
style="
display:block;
margin:0 auto;
background:#f3f0e8;
"></canvas>

<div style="font-size:16px; margin-top:10px;">
マスの番号と同じ色を選んでください。
</div>

<div id="mosaicPalette" style="
width:650px;
margin:10px auto 0 auto;
display:flex;
flex-wrap:wrap;
justify-content:center;
gap:5px;
"></div>

<button id="mosaicViewAll" style="
font-size:18px;
padding:9px 22px;
margin-top:15px;
">
全体を見る
</button>

<button id="mosaicFinish" style="
font-size:18px;
padding:9px 22px;
margin-top:15px;
">
やめる
</button>

</div>

<div id="mosaicAllView" style="
display:none;
text-align:center;
margin-top:15px;
">

<div style="font-size:22px; margin-bottom:10px;">
モザイクアート全体（制作途中）
</div>

<canvas id="mosaicAllCanvas"
width="320"
height="310"
style="
width:320px;
height:310px;
background:black;
"></canvas>

<br>

<button id="mosaicViewBack" style="
font-size:18px;
padding:9px 22px;
margin-top:10px;
">
制作画面に戻る
</button>

</div>

</div>

[endhtml]

[iscript]

var data = window.MOSAIC_DATA;

var canvas = document.getElementById("mosaicCanvas");
var ctx = canvas.getContext("2d");

var root = document.getElementById("mosaicRoot");
var menu = document.getElementById("mosaicMenu");
var work = document.getElementById("mosaicWork");
var areaButtons = document.getElementById("mosaicAreaButtons");
var paletteArea = document.getElementById("mosaicPalette");
var statusText = document.getElementById("mosaicStatus");

var selectedColor = -1;
var selectedArea = -1;
var placedCount = 0;
var finished = false;

var areaWidth = 32;
var areaHeight = 16;
var cellSize = 20;

// 塗ったマスの状態を保存
if (!f.mosaic_placed ||
f.mosaic_placed.length !== data.height) {

f.mosaic_placed = [];

for (var y = 0; y < data.height; y++) {
f.mosaic_placed[y] = [];

for (var x = 0; x < data.width; x++) {
f.mosaic_placed[y][x] = false;
}
}
}

var placed = f.mosaic_placed;

// 4段の高さ
var bandStarts = [0, 16, 32, 47];
var bandHeights = [16, 16, 15, 15];

function updateStatus() {
statusText.textContent =
"置いたマス：" + placedCount + " / 20";
}

// ゲームに戻る
function returnToGame() {

if (finished) return;

finished = true;

root.style.display = "none";

TYRANO.kag.ftag.startTag("jump", {
target: "*action_end"
});
}

function drawArea() {

ctx.fillStyle = "#f3f0e8";
ctx.fillRect(0, 0, canvas.width, canvas.height);

var areaColumn = selectedArea % 2;
var bandNumber = Math.floor(selectedArea / 2);

var startY = bandStarts[bandNumber];

for (var y = 0; y < areaHeight; y++) {
for (var x = 0; x < areaWidth; x++) {

var globalX = areaColumn * areaWidth + x;
var globalY = startY + y;

var colorNumber = data.grid[globalY][globalX];

if (placed[globalY][globalX]) {

ctx.fillStyle =
data.palette[String(colorNumber)].hex;

ctx.fillRect(
x * cellSize,
y * cellSize,
cellSize,
cellSize
);

} else {

ctx.fillStyle = "#f3f0e8";

ctx.fillRect(
x * cellSize,
y * cellSize,
cellSize,
cellSize
);

ctx.fillStyle = "#222222";
ctx.font = "bold 12px sans-serif";
ctx.textAlign = "center";
ctx.textBaseline = "middle";

ctx.fillText(
String(colorNumber),
x * cellSize + cellSize / 2,
y * cellSize + cellSize / 2
);
}

ctx.strokeStyle = "#777777";
ctx.lineWidth = 1;

ctx.strokeRect(
x * cellSize,
y * cellSize,
cellSize,
cellSize
);
}
}
}

function openArea(number) {

selectedArea = number;
selectedColor = -1;

var bandNumber = Math.floor(selectedArea / 2);

areaHeight = bandHeights[bandNumber];

canvas.width = areaWidth * cellSize;
canvas.height = areaHeight * cellSize;

canvas.style.width = (areaWidth * cellSize) + "px";
canvas.style.height = (areaHeight * cellSize) + "px";

menu.style.display = "none";
work.style.display = "block";

drawArea();
updateStatus();
}

// エリア選択ボタン
for (var i = 0; i < 8; i++) {

(function(number) {

var button = document.createElement("button");

button.textContent = "エリア " + (number + 1);
button.style.width = "120px";
button.style.height = "65px";
button.style.fontSize = "18px";

button.onclick = function() {

if (finished || placedCount >= 20) return;

openArea(number);
};

areaButtons.appendChild(button);

})(i);
}

// 15色のパレット
for (var i = 0; i < 15; i++) {

(function(number) {

var color = data.palette[String(number)];

var button = document.createElement("button");

button.textContent = number + " " + color.name;
button.style.backgroundColor = color.hex;
button.style.color = (number === 5) ? "#333" : "white";
button.style.margin = "3px";
button.style.padding = "8px";
button.style.border = "3px solid #777";

button.onclick = function() {

if (finished || placedCount >= 20) return;

selectedColor = number;

statusText.textContent =
"選択中：" + number + " " + color.name +
"　（" + placedCount + " / 20）";
};

paletteArea.appendChild(button);

})(i);
}

// マスをクリックしたとき
canvas.addEventListener("click", function(event) {

if (finished || placedCount >= 20) return;

if (selectedColor < 0) {

statusText.textContent = "先に色を選んでください！";
return;
}

var rect = canvas.getBoundingClientRect();

var localX =
(event.clientX - rect.left) * canvas.width / rect.width;

var localY =
(event.clientY - rect.top) * canvas.height / rect.height;

var x = Math.floor(localX / cellSize);
var y = Math.floor(localY / cellSize);

if (x < 0 || x >= areaWidth ||
y < 0 || y >= areaHeight) return;

var areaColumn = selectedArea % 2;
var bandNumber = Math.floor(selectedArea / 2);

var globalX = areaColumn * areaWidth + x;
var globalY = bandStarts[bandNumber] + y;

if (placed[globalY][globalX]) return;

var answer = data.grid[globalY][globalX];

if (selectedColor === answer) {

placed[globalY][globalX] = true;

placedCount++;

drawArea();
updateStatus();

if (placedCount >= 20) {

returnToGame();
}

} else {

statusText.textContent =
"色が違うみたい！もう一度挑戦してみよう！";
}
});

// 全体表示
document.getElementById("mosaicViewAll").onclick = function() {

var allView = document.getElementById("mosaicAllView");
var allCanvas = document.getElementById("mosaicAllCanvas");
var allCtx = allCanvas.getContext("2d");

menu.style.display = "none";
work.style.display = "none";
allView.style.display = "block";

allCanvas.width = 320;
allCanvas.height = 310;

var smallSize = 5;

// 全体を黒くする
allCtx.fillStyle = "#000000";
allCtx.fillRect(0, 0, 320, 310);

// 塗ったマスだけ色を付ける
for (var y = 0; y < data.height; y++) {
for (var x = 0; x < data.width; x++) {

if (placed[y][x]) {

var colorNumber = data.grid[y][x];

allCtx.fillStyle =
data.palette[String(colorNumber)].hex;

allCtx.fillRect(
x * smallSize,
y * smallSize,
smallSize,
smallSize
);
}
}
}
};

// 全体表示から制作画面に戻る
document.getElementById("mosaicViewBack").onclick = function() {

document.getElementById("mosaicAllView").style.display = "none";

work.style.display = "block";
};

// やめるボタン
document.getElementById("mosaicFinish").onclick = function() {

returnToGame();

};

menu.style.display = "block";
work.style.display = "none";
document.getElementById("mosaicAllView").style.display = "none";

[endscript]

[s]
[_tb_end_tyrano_code]

*action_end

[tb_eval  exp="f.period=15"  name="period"  cmd="="  op="t"  val="15"  val_2="undefined"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
今日はここまでにしよう[p]
[_tb_end_text]

*lunch_library

[tb_start_tyrano_code]
[bg storage="_library_room_1.jpg" time="500"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
放課後[p]
[_tb_end_text]

*plus_day

[tb_eval  exp="f.weekday+=1"  name="weekday"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.day+=1"  name="day"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="scene1.ks"  target="*next_day"  ]
[s  ]
