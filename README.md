# app_ui_kit

Librería de componentes UI para Flutter, construida con Material 3. Incluye tokens de diseño, tema centralizado y una colección de widgets listos para usar con soporte completo de light/dark mode.

---

## Instalación

Agrega la dependencia en tu `pubspec.yaml`. Puedes usar cualquiera de estas dos opciones:

**Desde GitHub (recomendado):**

```yaml
dependencies:
  app_ui_kit:
    git:
      url: https://github.com/slorduy/app_ui_kit.git
      ref: 1.0.0
```

**Desde ruta local:**

```yaml
dependencies:
  app_ui_kit:
    path: ../app_ui_kit  # ajusta la ruta según tu estructura
```

Luego ejecuta:

```bash
flutter pub get
```

---

## Configuración del tema

Aplica el tema en tu `MaterialApp` para que todos los componentes hereden los colores y tipografías correctamente:

```dart
import 'package:app_ui_kit/app_ui_kit.dart';

MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  home: MyHomePage(),
);
```

---

## Tokens de diseño

### Colores — `AppColors`

Paleta de colores centralizada con soporte para light y dark mode.

```dart
// Primarios
AppColors.primary500   // #6200EE
AppColors.primary700   // #3700B3

// Neutros
AppColors.neutral100 ... AppColors.neutral900

// Feedback
AppColors.error        // #B00020
AppColors.warning
AppColors.success
AppColors.info

// Semánticos (componentes)
AppColors.textPrimaryLight / AppColors.textPrimaryDark
AppColors.inputFillLight   / AppColors.inputFillDark
AppColors.cardFlatLight    / AppColors.cardFlatDark
// ... entre otros
```

### Espaciado — `AppSpacing`

| Token | Valor |
|-------|-------|
| `AppSpacing.xs` | 4.0 |
| `AppSpacing.sm` | 8.0 |
| `AppSpacing.md` | 16.0 |
| `AppSpacing.lg` | 24.0 |
| `AppSpacing.xl` | 32.0 |

### Tipografía — `AppTypography`

Escala tipográfica completa compatible con Material 3: `displayLarge`, `displayMedium`, `headlineLarge`, `headlineMedium`, `headlineSmall`, `titleLarge`, `titleMedium`, `titleSmall`, `bodyLarge`, `bodyMedium`, `bodySmall`, `labelLarge`, `labelMedium`, `labelSmall`.

---

## Componentes

### AppButton

Botón con 5 variantes y soporte de estado de carga, ícono y ancho completo.

**Variantes:** `primary` · `secondary` · `outline` · `ghost` · `danger`

```dart
// Constructor genérico
AppButton(
  label: 'Guardar',
  onPressed: () {},
  variant: AppButtonVariant.primary,
  isLoading: false,
  isFullWidth: true,
  icon: const Icon(Icons.save),
);

// Constructores nombrados (equivalentes)
AppButton.primary(label: 'Confirmar', onPressed: () {});
AppButton.secondary(label: 'Cancelar', onPressed: () {});
AppButton.outline(label: 'Ver más', onPressed: () {});
AppButton.ghost(label: 'Omitir', onPressed: () {});
AppButton.danger(label: 'Eliminar', onPressed: () {});
```

| Propiedad | Tipo | Default |
|-----------|------|---------|
| `label` | `String` | requerido |
| `onPressed` | `VoidCallback?` | requerido |
| `variant` | `AppButtonVariant` | `primary` |
| `isLoading` | `bool` | `false` |
| `isFullWidth` | `bool` | `false` |
| `icon` | `Widget?` | `null` |

---

### AppTextField

Campo de texto adaptable con soporte de contraseñas, validación, íconos y estados.

```dart
// Campo básico
AppTextField(
  label: 'Correo electrónico',
  hintText: 'nombre@ejemplo.com',
  helperText: 'Usaremos este correo para notificaciones',
  onChanged: (value) {},
  prefixIcon: const Icon(Icons.email_outlined),
);

// Estado de error
AppTextField(
  label: 'Email',
  errorText: 'Formato de correo inválido',
);

// Campo deshabilitado
AppTextField(
  label: 'Campo bloqueado',
  isDisabled: true,
);

// Constructor para contraseñas
AppTextField.password(
  controller: _passwordController,
  onChanged: (value) {},
  validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
);
```

| Propiedad | Tipo | Default |
|-----------|------|---------|
| `label` | `String?` | `null` |
| `hintText` | `String?` | `null` |
| `helperText` | `String?` | `null` |
| `errorText` | `String?` | `null` |
| `controller` | `TextEditingController?` | `null` |
| `isPassword` | `bool` | `false` |
| `isDisabled` | `bool` | `false` |
| `readOnly` | `bool` | `false` |
| `keyboardType` | `TextInputType` | `text` |
| `maxLines` | `int?` | `1` |

---

### AppCard

Contenedor con 3 variantes de estilo y soporte táctil opcional.

**Variantes:** `flat` · `outlined` · `elevated`

```dart
AppCard.flat(
  child: Text('Contenido flat'),
);

AppCard.outlined(
  padding: const EdgeInsets.all(20),
  child: Text('Con borde'),
);

AppCard.elevated(
  onTap: () => print('tapped'),
  child: Text('Elevado y tappable'),
);

// Control total
AppCard(
  variant: AppCardVariant.elevated,
  width: 200,
  borderRadius: BorderRadius.circular(16),
  child: Text('Custom'),
);
```

---

### AppModal

Bottom sheet modal con título, descripción, contenido personalizado y botones de acción.

```dart
AppModal.show(
  context: context,
  title: '¿Estás seguro?',
  description: 'Esta acción no se puede deshacer.',
  primaryActionLabel: 'Confirmar',
  onPrimaryAction: () {
    // lógica de confirmación
    Navigator.of(context).pop();
  },
  secondaryActionLabel: 'Cancelar',
);

// Con contenido personalizado
AppModal.show(
  context: context,
  title: 'Seleccionar país',
  content: MyCountryList(),
  isDismissible: true,
);
```

---

### AppBanner

Alerta informativa con 4 tipos semánticos, descripción y acciones opcionales.

**Tipos:** `info` · `success` · `warning` · `error`

```dart
AppBanner.info(
  title: 'Actualización disponible',
  description: 'Hay una nueva versión lista para instalar.',
);

AppBanner.success(
  title: 'Pago procesado',
  onClose: () {},
);

AppBanner.warning(
  title: 'Sesión por expirar',
  description: 'Tu sesión cerrará en 5 minutos.',
  action: TextButton(onPressed: () {}, child: Text('Extender')),
);

AppBanner.error(
  title: 'Error de conexión',
  description: 'No se pudo completar la operación.',
);
```

---

### AppLoader

Indicador de carga circular con tamaños y variantes de color. En iOS usa `CupertinoActivityIndicator`.

**Tamaños:** `small` (16px) · `medium` (28px) · `large` (44px)

```dart
// Tamaños
const AppLoader();               // medium por defecto
const AppLoader.small();
const AppLoader.large();

// Variantes de color
const AppLoader.onPrimary();     // blanco, para usar sobre fondos de color
const AppLoader.neutral();       // gris neutro

// Progreso determinado
AppLoader(value: 0.7);           // 70% completado
```

---

### AppChip

Etiqueta compacta con 4 variantes de comportamiento.

**Variantes:** `filter` · `action` · `deletable` · `status`

```dart
// Chip de filtro (seleccionable)
AppChip.filter(
  label: 'Flutter',
  isSelected: _isSelected,
  onPressed: () => setState(() => _isSelected = !_isSelected),
);

// Chip de acción
AppChip.action(
  label: 'Compartir',
  onPressed: () {},
  avatar: const Icon(Icons.share, size: 14),
);

// Chip eliminable
AppChip.deletable(
  label: 'React',
  onDeleted: () {},
);

// Chip de estado (decorativo, sin acción)
AppChip.status(
  label: 'Activo',
  backgroundColor: AppColors.success,
  labelColor: AppColors.bannerSuccessContentLight,
);
```

---

### AppSelect

Selector tipo dropdown que abre un `AppModal` con la lista de opciones.

```dart
AppSelect<String>(
  label: 'País',
  hintText: 'Selecciona un país',
  value: _selectedCountry,
  items: const [
    AppSelectItem(value: 'co', label: 'Colombia'),
    AppSelectItem(value: 'mx', label: 'México'),
    AppSelectItem(value: 'ar', label: 'Argentina'),
  ],
  onChanged: (value) => setState(() => _selectedCountry = value),
);

// Con íconos por opción
AppSelect<String>(
  label: 'Método de pago',
  value: _method,
  items: [
    AppSelectItem(
      value: 'card',
      label: 'Tarjeta de crédito',
      icon: const Icon(Icons.credit_card),
    ),
    AppSelectItem(
      value: 'cash',
      label: 'Efectivo',
      icon: const Icon(Icons.money),
    ),
  ],
  onChanged: (v) => setState(() => _method = v),
);
```

---

### AppEmptyState

Pantalla vacía con ícono, título, descripción y acción opcional.

```dart
// Presets listos
const AppEmptyState.noData();
const AppEmptyState.noResults(onAction: clearSearch);
const AppEmptyState.error(onAction: retry);

// Personalizado
AppEmptyState(
  icon: Icons.bookmark_outline,
  title: 'Sin favoritos',
  description: 'Guarda elementos para verlos aquí.',
  actionLabel: 'Explorar',
  onAction: () {},
);
```

---

### AppText / AppRadioButton / AppRadioGroup

Consulta los archivos fuente para la API detallada de estos componentes:

- `lib/src/components/app_text.dart`
- `lib/src/components/app_radio_button.dart`
- `lib/src/components/app_radio_group.dart`

---

## Estructura del paquete

```
lib/
├── app_ui_kit.dart          # Punto de entrada, exporta todo
└── src/
    ├── components/          # Widgets
    │   ├── app_banner.dart
    │   ├── app_button.dart
    │   ├── app_card.dart
    │   ├── app_chip.dart
    │   ├── app_empty_state.dart
    │   ├── app_loader.dart
    │   ├── app_modal.dart
    │   ├── app_radio_button.dart
    │   ├── app_radio_group.dart
    │   ├── app_select.dart
    │   ├── app_text.dart
    │   └── app_text_field.dart
    ├── enums/               # Enums de variantes y tamaños
    ├── theme/               # AppTheme (light/dark)
    └── tokens/              # AppColors, AppSpacing, AppTypography
```

---

## Requisitos

- Flutter `>=1.17.0`
- Dart SDK `^3.13.2`
