<script>
(function () {
  function initTocTree() {
    const toc = document.querySelector('nav#TOC, #TOC, .sidebar nav[role="doc-toc"]');
    if (!toc || toc.dataset.tocEnhanced === 'true') return;
    toc.dataset.tocEnhanced = 'true';
    toc.classList.add('toc-collapsible', 'toc-site-like');

    const controls = document.createElement('div');
    controls.id = 'toc-controls';
    controls.innerHTML = `
      <button type="button" id="toc-expand-all" aria-label="Développer toute la table des matières">Développer</button>
      <button type="button" id="toc-collapse-all" aria-label="Réduire toute la table des matières">Réduire</button>
    `;
    toc.insertBefore(controls, toc.firstChild);

    toc.querySelectorAll('li').forEach(function (li) {
      const child = li.querySelector(':scope > ul');
      const link = li.querySelector(':scope > a');
      if (!child || !link) return;

      li.classList.add('toc-has-children');
      const btn = document.createElement('button');
      btn.className = 'toc-toggle';
      btn.type = 'button';
      btn.setAttribute('aria-label', 'Développer ou réduire cette section');
      btn.setAttribute('aria-expanded', 'true');
      btn.textContent = '▾';
      btn.addEventListener('click', function (ev) {
        ev.preventDefault();
        ev.stopPropagation();
        const collapsed = li.classList.toggle('toc-collapsed');
        btn.textContent = collapsed ? '▸' : '▾';
        btn.setAttribute('aria-expanded', collapsed ? 'false' : 'true');
      });
      li.insertBefore(btn, link);
    });

    function expandAll() {
      toc.querySelectorAll('li.toc-collapsed').forEach(function (li) {
        li.classList.remove('toc-collapsed');
        const b = li.querySelector(':scope > .toc-toggle');
        if (b) {
          b.textContent = '▾';
          b.setAttribute('aria-expanded', 'true');
        }
      });
    }

    function collapseAll() {
      toc.querySelectorAll('li.toc-has-children').forEach(function (li) {
        li.classList.add('toc-collapsed');
        const b = li.querySelector(':scope > .toc-toggle');
        if (b) {
          b.textContent = '▸';
          b.setAttribute('aria-expanded', 'false');
        }
      });
      const active = toc.querySelector('a.active, a[aria-current="true"]');
      if (active) {
        let li = active.closest('li');
        while (li) {
          li.classList.remove('toc-collapsed');
          const b = li.querySelector(':scope > .toc-toggle');
          if (b) {
            b.textContent = '▾';
            b.setAttribute('aria-expanded', 'true');
          }
          li = li.parentElement ? li.parentElement.closest('li') : null;
        }
      }
    }

    const expandBtn = controls.querySelector('#toc-expand-all');
    const collapseBtn = controls.querySelector('#toc-collapse-all');
    expandBtn.addEventListener('click', expandAll);
    collapseBtn.addEventListener('click', collapseAll);

    // Start in a readable mode: main sections visible, deep subsections folded.
    toc.querySelectorAll('li.toc-has-children').forEach(function (li) {
      const depth = li.parentsDepth || 0;
      const nestedUl = li.closest('ul');
      const topList = toc.querySelector(':scope > ul, :scope > div > ul');
      if (nestedUl && topList && nestedUl !== topList) {
        li.classList.add('toc-collapsed');
        const b = li.querySelector(':scope > .toc-toggle');
        if (b) {
          b.textContent = '▸';
          b.setAttribute('aria-expanded', 'false');
        }
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTocTree);
  } else {
    initTocTree();
  }
})();
</script>
