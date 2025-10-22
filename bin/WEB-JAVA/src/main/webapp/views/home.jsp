<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>AloTra - Trà sữa chuẩn vị</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
  <style>
    .btn-alotra{background:#6f42c1;border-color:#6f42c1}.btn-alotra:hover{filter:brightness(.95)}
    .hover-lift{transition:transform .3s, box-shadow .3s}
    .hover-lift:hover{transform:translateY(-5px);box-shadow:0 10px 20px rgba(0,0,0,.1)!important}
  </style>
</head>
<body>

<!-- Navbar với Login/Logout (góc phải) + phân quyền đơn giản -->
<nav class="navbar navbar-expand-lg bg-light border-bottom">
  <div class="container">
    <a class="navbar-brand fw-semibold" href="${pageContext.request.contextPath}/home">AloTra</a>

    <div class="ms-auto d-flex align-items-center gap-2">
      <c:if test="${not empty sessionScope.currentUser && sessionScope.currentUser.roleId == 1}">
        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin">Admin</a>
      </c:if>

      <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
          <span class="text-muted small d-none d-md-inline">
            <i class="bi bi-person-circle me-1"></i>${sessionScope.currentUser.fullName}
          </span>
          <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/logout">Logout</a>
        </c:when>
        <c:otherwise>
          <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/login">Login</a>
          <a class="btn btn-sm btn-alotra text-white" href="${pageContext.request.contextPath}/register">Đăng ký</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>

<!-- Hero -->
<section class="hero py-5 mb-4 bg-light">
  <div class="container py-5">
    <div class="row align-items-center gy-4">
      <div class="col-lg-6">
        <h1 class="display-5 fw-bold text-dark">AloTra – Thưởng thức trà sữa chuẩn vị mỗi ngày</h1>
        <p class="lead text-muted mt-3">Từ trà sữa truyền thống đến công thức sáng tạo, AloTra sẵn sàng phục vụ bạn.</p>
        <a href="#menu" class="btn btn-alotra text-white px-4 py-2 mt-3"><i class="bi bi-cup-straw me-2"></i>Khám phá menu</a>
      </div>
      <div class="col-lg-6 text-center">
        <img src="https://images.unsplash.com/photo-1580915411954-282cb1c8abca?w=800" alt="Trà sữa"
             class="img-fluid rounded-4 shadow" loading="lazy">
      </div>
    </div>
  </div>
</section>

<!-- Menu + tìm kiếm -->
<section id="menu" class="container pb-5">
  <div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
    <h2 class="fw-semibold mb-3 mb-md-0"><i class="bi bi-cup-hot me-2 text-primary"></i>Menu hôm nay</h2>

    <c:url var="searchUrl" value="/home">
      <c:if test="${not empty activeCategory}">
        <c:param name="category" value="${activeCategory}"/>
      </c:if>
    </c:url>

    <form class="d-flex" method="get" action="${pageContext.request.contextPath}${searchUrl}">
      <div class="input-group" style="min-width:300px;">
        <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
        <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm món..." value="${keyword}">
        <button class="btn btn-alotra text-white" type="submit">Tìm</button>
      </div>
    </form>
  </div>

  <!-- Bộ lọc danh mục -->
  <div class="mb-4">
    <div class="nav gap-2 flex-wrap">
      <a class="btn btn-outline-dark ${empty activeCategory and empty keyword ? 'active' : ''}"
         href="${pageContext.request.contextPath}/home">
        <i class="bi bi-grid me-1"></i>Tất cả
      </a>
      <c:forEach items="${categories}" var="cate">
        <c:url var="cateUrl" value="/home">
          <c:param name="category" value="${cate.id}"/>
          <c:if test="${not empty keyword}">
            <c:param name="keyword" value="${keyword}"/>
          </c:if>
        </c:url>
        <a class="btn btn-outline-dark ${activeCategory == cate.id ? 'active' : ''}"
           href="${pageContext.request.contextPath}${cateUrl}">
          <c:if test="${not empty cate.icon}">
            <img src="${pageContext.request.contextPath}/${cate.icon}" alt="${cate.name}"
                 class="me-1" style="width:20px;height:20px;object-fit:cover;border-radius:4px;">
          </c:if>
          ${cate.name}
        </a>
      </c:forEach>
    </div>
  </div>

  <!-- Thông báo tìm kiếm -->
  <c:if test="${not empty keyword}">
    <div class="alert alert-info">
      <i class="bi bi-search me-2"></i>
      Tìm thấy <strong>${pagination.totalItems}</strong> kết quả cho "<strong>${keyword}</strong>"
      <a href="${pageContext.request.contextPath}/home" class="ms-2 text-decoration-none"><i class="bi bi-x-circle"></i> Xóa</a>
    </div>
  </c:if>

  <!-- Danh sách món -->
  <c:choose>
    <c:when test="${empty drinks}">
      <div class="text-center py-5 text-muted">
        <i class="bi bi-inbox display-1"></i>
        <h4 class="mt-3"><c:out value="${not empty keyword ? 'Không tìm thấy món nào' : 'Danh sách món sẽ sớm cập nhật!'}"/></h4>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row g-4">
        <c:forEach items="${drinks}" var="drink">
          <div class="col-md-4 col-lg-3">
            <div class="card border-0 shadow-sm h-100 hover-lift">
              <c:choose>
                <c:when test="${not empty drink.thumbnail}">
                  <img src="${drink.thumbnail}" class="card-img-top" alt="${drink.name}" style="height:200px;object-fit:cover;" loading="lazy">
                </c:when>
                <c:otherwise>
                  <img src="https://images.unsplash.com/photo-1511920170033-f8396924c348?w=600" class="card-img-top" alt="${drink.name}" style="height:200px;object-fit:cover;" loading="lazy">
                </c:otherwise>
              </c:choose>
              <div class="card-body d-flex flex-column">
                <h5 class="card-title">${drink.name}</h5>
                <p class="card-text text-muted flex-grow-1 small">
                  ${empty drink.description ? 'Một lựa chọn tuyệt vời cho ngày mới!' : drink.description}
                </p>
                <div class="d-flex align-items-center justify-content-between mt-2">
                  <span class="fw-bold text-primary fs-5"><fmt:formatNumber value="${drink.price}" pattern="#,##0₫"/></span>
                  <button class="btn btn-sm btn-alotra text-white"><i class="bi bi-cart-plus me-1"></i>Đặt</button>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Phân trang -->
      <c:if test="${pagination.totalPages > 1}">
        <nav class="mt-5">
          <ul class="pagination justify-content-center">
            <c:set var="prevPage" value="${pagination.currentPage > 1 ? pagination.currentPage - 1 : 1}"/>
            <c:url var="prevUrl" value="/home">
              <c:param name="page" value="${prevPage}"/>
              <c:if test="${not empty activeCategory}"><c:param name="category" value="${activeCategory}"/></c:if>
              <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
            </c:url>
            <li class="page-item ${pagination.currentPage <= 1 ? 'disabled' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}${prevUrl}" tabindex="-1"><i class="bi bi-chevron-left"></i></a>
            </li>

            <c:forEach begin="1" end="${pagination.totalPages}" var="i">
              <c:if test="${i == 1 || i == pagination.totalPages || (i >= pagination.currentPage - 2 && i <= pagination.currentPage + 2)}">
                <c:url var="pageUrl" value="/home">
                  <c:param name="page" value="${i}"/>
                  <c:if test="${not empty activeCategory}"><c:param name="category" value="${activeCategory}"/></c:if>
                  <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                </c:url>
                <li class="page-item ${i == pagination.currentPage ? 'active' : ''}">
                  <a class="page-link" href="${pageContext.request.contextPath}${pageUrl}">${i}</a>
                </li>
              </c:if>
            </c:forEach>

            <c:set var="nextPage" value="${pagination.currentPage < pagination.totalPages ? pagination.currentPage + 1 : pagination.totalPages}"/>
            <c:url var="nextUrl" value="/home">
              <c:param name="page" value="${nextPage}"/>
              <c:if test="${not empty activeCategory}"><c:param name="category" value="${activeCategory}"/></c:if>
              <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
            </c:url>
            <li class="page-item ${pagination.currentPage >= pagination.totalPages ? 'disabled' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}${nextUrl}"><i class="bi bi-chevron-right"></i></a>
            </li>
          </ul>
          <p class="text-center text-muted small mb-0">
            Hiển thị ${pagination.startItem} - ${pagination.endItem} / ${pagination.totalItems} món
          </p>
        </nav>
      </c:if>
    </c:otherwise>
  </c:choose>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
