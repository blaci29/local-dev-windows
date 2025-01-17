# FastAPI Alapú Iránymutatás és Prompt

## FastAPI Alapelvek

### 1. **Modularitás**
   - Használj **APIRouter**-t az útvonalak logikai csoportosításához.
   - Külön fájlokba szervezd a modelleket, szolgáltatásokat és útvonalakat.
   - Példa:
     ```python
     from fastapi import APIRouter

     router = APIRouter()

     @router.get("/items/{item_id}")
     async def read_item(item_id: int):
         return {"item_id": item_id}
     ```

### 2. **Dokumentáció**
   - Használd a FastAPI automatikus **Swagger/OpenAPI** dokumentációját.
   - Adj hozzá részletes leírást és példákat az API végpontokhoz.
   - Példa:
     ```python
     from fastapi import FastAPI

     app = FastAPI(
         title="My API",
         description="API for transcribing audio files.",
         version="1.0.0",
     )

     @app.get("/items/{item_id}", summary="Get an item by ID", response_description="The requested item")
     async def read_item(item_id: int):
         """
         Retrieve an item by its ID.

         - **item_id**: The ID of the item to retrieve.
         """
         return {"item_id": item_id}
     ```

### 3. **Hibakezelés**
   - Implementálj egyéni hibakezelőket a `@app.exception_handler` segítségével.
   - Használd a Pydantic modelleket a bemeneti és kimeneti adatok validálására.
   - Példa:
     ```python
     from fastapi import HTTPException, Request
     from fastapi.responses import JSONResponse

     @app.exception_handler(HTTPException)
     async def custom_http_exception_handler(request: Request, exc: HTTPException):
         return JSONResponse(status_code=exc.status_code, content={"detail": exc.detail})
     ```

### 4. **Kérés életciklus**
   - Használj **middleware**-eket a kérések és válaszok kezelésére.
   - Függőségek (`Depends`) használata a kód újrafelhasználhatóságához.
   - Példa:
     ```python
     from fastapi import Request

     @app.middleware("http")
     async def add_process_time_header(request: Request, call_next):
         response = await call_next(request)
         response.headers["X-Custom-Header"] = "Custom Value"
         return response
     ```

### 5. **Adatbázis**
   - Használj **SQLAlchemy**-t vagy más ORM-et az adatbázis kezelésére.
   - Migrációk kezelésére használj **Alembic**-et.
   - Példa:
     ```python
     from sqlalchemy import create_engine
     from sqlalchemy.ext.declarative import declarative_base
     from sqlalchemy.orm import sessionmaker

     SQLALCHEMY_DATABASE_URL = "sqlite:///./sql_app.db"
     engine = create_engine(SQLALCHEMY_DATABASE_URL)
     SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
     Base = declarative_base()
     ```

### 6. **Hitelesítés**
   - Implementálj **JWT alapú hitelesítést** a `fastapi.security` modullal.
   - Használj függőségeket az engedélyezések kezelésére.
   - Példa:
     ```python
     from fastapi.security import OAuth2PasswordBearer
     from fastapi import Depends, HTTPException

     oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

     async def get_current_user(token: str = Depends(oauth2_scheme)):
         user = fake_decode_token(token)
         if not user:
             raise HTTPException(status_code=401, detail="Invalid authentication credentials")
         return user
     ```

### 7. **Naplózás**
   - Használd a Python **logging** modulját a naplózásra.
   - Konfiguráld a naplózási szinteket és formátumokat.
   - Példa:
     ```python
     import logging

     logger = logging.getLogger("my_api")
     logger.setLevel(logging.INFO)
     ```

### 8. **Tesztelés**
   - Írj **egységteszteket** a `pytest` segítségével.
   - Használj **TestClient**-et az API végpontok tesztelésére.
   - Példa:
     ```python
     from fastapi.testclient import TestClient

     client = TestClient(app)

     def test_read_item():
         response = client.get("/items/42")
         assert response.status_code == 200
         assert response.json() == {"item_id": 42}
     ```

---
