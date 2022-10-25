edge(va, vb, 40).
edge(va, vh, 40).
edge(va, vi, 90).
edge(va, vc, 150).
edge(vb, va, 40).
edge(vb, vg, 50).
edge(vb, vc, 80).
edge(vb, vd, 110).
edge(vc, vb, 80).
edge(vc, vf, 80).
edge(vc, va, 150).
edge(vc, vd, 60).
edge(vd, vc, 60).
edge(vd, vb, 110).
edge(vd, ve, 80).
edge(vd, vl, 90).
edge(ve, vd, 80).
edge(ve, vf, 70).
edge(ve, vl, 30).
edge(ve, vm, 90).
edge(vf, ve, 70).
edge(vf, vc, 80).
edge(vf, vk, 110).
edge(vf, vg, 40).
edge(vg, vf, 40).
edge(vg, vb, 50).
edge(vg, vh, 20).
edge(vg, vj, 90).
edge(vh, vg, 20).
edge(vh, va, 40).
edge(vh, vp, 120).
edge(vh, vi, 80).
edge(vi, vh, 80).
edge(vi, va, 90).
edge(vi, vp, 60).
edge(vi, vj, 60).
edge(vj, vi, 60).
edge(vj, vg, 90).
edge(vj, vq, 30).
edge(vj, vk, 60).
edge(vk, vj, 60).
edge(vk, vf, 110).
edge(vk, vn, 30).
edge(vk, vl, 40).
edge(vl, vk, 40).
edge(vl, ve, 30).
edge(vl, vd, 90).
edge(vl, vm, 60).
edge(vm, vl, 60).
edge(vm, ve, 90).
edge(vm, vq, 80).
edge(vm, vn, 60).
edge(vn, vm, 60).
edge(vn, vq, 60).
edge(vn, vk, 30).
edge(vn, vp, 80).
edge(vq, vn, 60).
edge(vq, vj, 30).
edge(vq, vm, 80).
edge(vq, vp, 30).
edge(vp, vq, 30).
edge(vp, vi, 60).
edge(vp, vh, 120).
edge(vp, vn, 80).

coordinate(va, 90, 160).
coordinate(vb, 70, 140).
coordinate(vc, 40, 80).
coordinate(vd, 70, 40).
coordinate(ve, 130, 60).
coordinate(vf, 100, 100).
coordinate(vg, 110, 130).
coordinate(vh, 110, 150).
coordinate(vi, 170, 160).
coordinate(vj, 160, 130).
coordinate(vk, 180, 70).
coordinate(vl, 150, 50).
coordinate(vm, 190, 30).
coordinate(vn, 210, 70).
coordinate(vq, 190, 110).
coordinate(vp, 200, 130).

getedge(V1, V2, Cost) :- edge(V1, V2, Cost).
getedge(V1, V2, Cost) :- edge(V2, V1, Cost).

distancecalc(Xa, Ya, Xb, Yb, Result) :-
       Result is round(100*sqrt((Xa - Xb)*(Xa - Xb) + (Ya - Yb)*(Ya - Yb)))/100.

distanceSL(V1, V2, SLD) :-
        coordinate(V1, X1, Y1),
        coordinate(V2, X2, Y2),
        distancecalc(X1, Y1, X2, Y2, SLD).

