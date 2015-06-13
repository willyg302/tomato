!function t(e,n,r){function i(a,s){if(!n[a]){if(!e[a]){var u="function"==typeof require&&require;if(!s&&u)return u(a,!0);if(o)return o(a,!0);var l=new Error("Cannot find module '"+a+"'");throw l.code="MODULE_NOT_FOUND",l}var c=n[a]={exports:{}};e[a][0].call(c.exports,function(t){var n=e[a][1][t];return i(n?n:t)},c,c.exports,t,e,n,r)}return n[a].exports}for(var o="function"==typeof require&&require,a=0;a<r.length;a++)i(r[a]);return i}({1:[function(t,e,n){var r,i,o,a;r=t("./audio-source.coffee"),i=t("./soundcloud-loader.coffee"),o=t("./visualizer.coffee"),plyr.setup({controls:["restart","play","current-time","duration","mute","volume"]}),particlesJS("particles",{particles:{number:{value:100},color:{value:"#ffffff"},shape:{type:"circle"},opacity:{value:.5},size:{value:3,random:!0},line_linked:{enable:!1},move:{enable:!0,speed:2,direction:"top",out_mode:"out"}},interactivity:{events:{onhover:{enable:!1}}},retina_detect:!0}),a=function(t){var e,n,r,i,o;return o=t.sound,document.getElementById("infoImage").setAttribute("src",null!=(r=o.artwork_url)?r:o.user.avatar_url),e=function(t,e,n){var r,i;return r=document.createElement("a"),r.setAttribute("href",t),r.innerHTML=e,i=document.getElementById(n),i.innerHTML="",i.appendChild(r)},n=o.user.username,"playlist"===o.kind&&(n+=" ["+o.title+"]"),e(o.user.permalink_url,n,"infoArtist"),i="playlist"===o.kind?o.tracks[t.playlistIndex].title:o.title,e(o.permalink_url,i,"infoTrack"),window.location.hash=o.permalink_url.substr(22)},window.onload=function(){var t,e,n,s,u,l,c;return document.body.className="",s=document.getElementById("player"),n=new i(s,a),u=new r(s,n),c=new o("visualizer",u),e=function(t){return n.loadStream(t,function(t){return u.playStream(t()),a(n),document.body.className="playing"},function(t){return console.error(t)})},window.pJSDom[0].pJS.fn.particlesRefresh(),e(window.location.hash?"https://soundcloud.com/"+window.location.hash.substr(1):"https://soundcloud.com/mrsuicidesheep/attom-glow"),l=document.getElementById("submit"),l.onkeypress=function(t){var n;switch(t.stopPropagation(),t.keyCode){case 10:case 13:return n=l.value,l.value="",e(n)}},t=function(t){switch(t.keyCode){case 32:return n.toggle();case 37:return n.forward();case 39:return n.backward()}},window.addEventListener("keydown",t,!1)}},{"./audio-source.coffee":2,"./soundcloud-loader.coffee":3,"./visualizer.coffee":4}],2:[function(t,e,n){var r;r=function(){function t(t,e){var n;this.player=t,this.loader=e,n=new(window.AudioContext||window.webkitAudioContext),this.analyser=n.createAnalyser(),n.createMediaElementSource(this.player).connect(this.analyser),this.analyser.connect(n.destination),this.volume=0,this.streamData=new Uint8Array(this.analyser.frequencyBinCount)}return t.prototype._sampleAudioStream=function(){return this.analyser.getByteFrequencyData(this.streamData)},t.prototype.playStream=function(t){return this.player.addEventListener("ended",function(t){return function(){return t.loader.coast()}}(this)),this.player.setAttribute("src",t),this.player.play(),setInterval(function(t){return function(){return t._sampleAudioStream()}}(this),20)},t}(),e.exports=r},{}],3:[function(t,e,n){var r;r=function(){function t(t,e){var n;this.player=t,this.updater=e,n="116aeada3811cb64c5bbf30c82303e0d",this.client_id=n.split("").map(function(t){return((parseInt(t,16)+13)%16).toString(16)}).join(""),this.sound={}}return t.prototype.loadStream=function(t,e,n){return SC.initialize({client_id:this.client_id}),SC.get("/resolve",{url:t},function(t){return function(r){return r.errors?n(r.errors).map(function(t){return t.error_message}).join("\n"):(t.sound=r,"playlist"===r.kind?(t.playlistIndex=0,t.streamUrl=function(){return t.sound.tracks[t.playlistIndex].stream_url+"?client_id="+t.client_id}):(t.sound=r,t.streamUrl=function(){return t.sound.stream_url+"?client_id="+t.client_id}),e(t.streamUrl))}}(this))},t.prototype._update=function(){return this.playlistIndex>=0&&this.playlistIndex<=this.sound.track_count-1?(this.player.setAttribute("src",this.streamUrl()),this.updater(this),this.player.play()):void 0},t.prototype.coast=function(){return"playlist"===this.sound.kind?(this.playlistIndex++,this._update()):void 0},t.prototype.toggle=function(){return this.player.paused?this.player.play():this.player.pause()},t.prototype.forward=function(){return"playlist"===this.sound.kind?(this.playlistIndex=(this.playlistIndex+1)%this.sound.track_count,this._update()):void 0},t.prototype.backward=function(){return"playlist"===this.sound.kind?(this.playlistIndex=(this.playlistIndex-1+this.sound.track_count)%this.sound.track_count,this._update()):void 0},t}(),e.exports=r},{}],4:[function(t,e,n){var r,i=function(t,e){return function(){return t.apply(e,arguments)}};r=function(){function t(t,e){var n;this.audioSource=e,this._draw=i(this._draw,this),n=document.createElement("canvas"),n.width=384,n.height=384,this.context=n.getContext("2d"),document.getElementById(t).appendChild(n),this._draw()}return t.prototype._draw=function(){var t,e,n;for(this.context.clearRect(0,0,384,384),this.context.fillStyle="#ffffff",this.context.shadowColor="#ffffff",this.context.shadowBlur=10,this.context.shadowOffsetX=0,this.context.shadowOffsetY=0,this.context.lineCap="round",t=e=0;127>=e;t=++e)this.context.save(),this.context.translate(192,192),n=this.audioSource.streamData[t],this.context.rotate(-.039516888724399915*t-3.765959495435312),this.context.fillRect(0,112,2,n/4),this.context.restore();return window.requestAnimationFrame(this._draw)},t}(),e.exports=r},{}]},{},[1]);