(function () {
  const root = document.getElementById('simulateur');
  if (!root) return;
  root.innerHTML = `
  <div class="sim-card">
    <label>Économie annuelle d’énergie <b><span id="gain-label">500</span> MWh</b></label>
    <input id="gain-slider" type="range" min="300" max="650" step="5" value="500">
    <div class="sim-grid">
      <div><span>Besoin initial</span><strong id="sim-initial"></strong><small>kMAD</small></div>
      <div><span>Flux d’exploitation</span><strong id="sim-opex"></strong><small>kMAD/an</small></div>
      <div><span>VAN à 10 %</span><strong id="sim-van"></strong><small>kMAD</small></div>
    </div>
    <p id="sim-avis" class="sim-avis"></p>
    <canvas id="sim-chart" width="760" height="260" aria-label="VAN selon économie annuelle"></canvas>
    <p class="sim-note">Hypothèses inchangées : prix 1,20 MAD/kWh, maintenance 60 kMAD, opportunité 36 kMAD, impôt 30 %, huit ans, cession nette 140 kMAD et récupération du BFR 120 kMAD.</p>
  </div>`;
  const slider = root.querySelector('#gain-slider'), ctx = root.querySelector('#sim-chart').getContext('2d');
  const annuity = Array.from({length:8},(_,i)=>1/Math.pow(1.1,i+1)).reduce((a,b)=>a+b,0);
  function calc(mwh){
    const savings=mwh*1.2, ebit=savings-60-36-250, tax=ebit*.30;
    const op=ebit-tax+250, van=-2120+op*annuity+260/Math.pow(1.1,8);
    return {op,van};
  }
  function fmt(x){return x.toLocaleString('fr-FR',{minimumFractionDigits:1,maximumFractionDigits:1});}
  function draw(current){
    const W=ctx.canvas.width,H=ctx.canvas.height,pad={l:62,r:22,t:18,b:44};ctx.clearRect(0,0,W,H);
    const xs=[];for(let x=300;x<=650;x+=5)xs.push(x);const ys=xs.map(x=>calc(x).van);
    const ymin=Math.min(...ys),ymax=Math.max(...ys),X=x=>pad.l+(x-300)/350*(W-pad.l-pad.r),Y=y=>pad.t+(ymax-y)/(ymax-ymin)*(H-pad.t-pad.b);
    ctx.strokeStyle='#d8e2ef';ctx.lineWidth=1;ctx.beginPath();ctx.moveTo(pad.l,Y(0));ctx.lineTo(W-pad.r,Y(0));ctx.stroke();
    ctx.strokeStyle='#1f4e79';ctx.lineWidth=3;ctx.beginPath();xs.forEach((x,i)=>i?ctx.lineTo(X(x),Y(ys[i])):ctx.moveTo(X(x),Y(ys[i])));ctx.stroke();
    const c=calc(current);ctx.fillStyle=c.van>=0?'#1f4e79':'#c00000';ctx.beginPath();ctx.arc(X(current),Y(c.van),6,0,Math.PI*2);ctx.fill();
    ctx.fillStyle='#334155';ctx.font='15px sans-serif';ctx.fillText('300',X(300)-10,H-18);ctx.fillText('650',X(650)-10,H-18);ctx.fillText('MWh économisés',W/2-50,H-10);ctx.fillText('VAN',12,25);ctx.fillText('0',38,Y(0)+5);
  }
  function update(){const m=+slider.value,c=calc(m);root.querySelector('#gain-label').textContent=m;root.querySelector('#sim-initial').textContent='2 120,0';root.querySelector('#sim-opex').textContent=fmt(c.op);root.querySelector('#sim-van').textContent=fmt(c.van);const a=root.querySelector('#sim-avis');a.textContent=c.van>=0?'VAN positive sous les hypothèses actuelles : poursuivre l’instruction et vérifier les preuves.':'VAN négative sous les hypothèses actuelles : réviser ou rejeter le dossier.';a.className='sim-avis '+(c.van>=0?'positive':'negative');draw(m);}
  slider.addEventListener('input',update);update();
})();
