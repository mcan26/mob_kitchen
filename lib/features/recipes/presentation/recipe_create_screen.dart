import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/aisle_category.dart';
import '../../../core/domain/measurement_unit.dart';
import '../../../core/theme/mob_colors.dart';
import '../domain/entities/macros.dart';
import '../domain/entities/recipe.dart';
import '../domain/entities/recipe_enums.dart';
import '../domain/entities/recipe_ingredient.dart';
import '../domain/entities/recipe_step.dart';
import '../providers/recipe_providers.dart';

class RecipeCreateScreen extends ConsumerStatefulWidget {
  const RecipeCreateScreen({
    super.key,
    this.editRecipeId,
  });

  final String? editRecipeId;

  @override
  ConsumerState<RecipeCreateScreen> createState() => _RecipeCreateScreenState();
}

class _RecipeCreateScreenState extends ConsumerState<RecipeCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Basic info controllers
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _prepTimeController = TextEditingController(text: '10');
  final _cookTimeController = TextEditingController(text: '20');
  final _servingsController = TextEditingController(text: '2');
  final _tagsController = TextEditingController(text: 'Homemade, Dinner');
  final _storageTipController = TextEditingController(text: 'Store in an airtight container for up to 3 days.');

  // Macro controllers
  final _kcalController = TextEditingController(text: '520');
  final _proteinController = TextEditingController(text: '34');
  final _carbsController = TextEditingController(text: '48');
  final _fatController = TextEditingController(text: '18');

  RecipeCategory _selectedCategory = RecipeCategory.onePot;
  Difficulty _selectedDifficulty = Difficulty.medium;

  // Dynamic ingredient & step drafts
  final List<_IngredientDraft> _ingredients = [];
  final List<_StepDraft> _steps = [];
  final List<TextEditingController> _goldenRuleControllers = [];

  bool _initializedFromExisting = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Default initial template if creating new
    if (widget.editRecipeId == null) {
      _ingredients.add(_IngredientDraft(
        name: 'Chicken Breast / Tofu',
        amount: '350',
        unit: MeasurementUnit.gram,
        aisle: AisleCategory.butcherDeli,
        buyingTip: 'Look for fresh, firm cuts.',
      ));
      _ingredients.add(_IngredientDraft(
        name: 'Olive Oil',
        amount: '2',
        unit: MeasurementUnit.tablespoon,
        aisle: AisleCategory.spices,
      ));
      _ingredients.add(_IngredientDraft(
        name: 'Garlic',
        amount: '3',
        unit: MeasurementUnit.clove,
        aisle: AisleCategory.produce,
      ));

      _steps.add(_StepDraft(
        title: 'Prep & Sear',
        instruction: 'Heat olive oil in a wide skillet over medium-high heat. Sear until golden on all sides.',
        sensoryCue: 'When edges sizzle and turn a deep golden amber.',
        chefTip: 'Do not overcrowd the pan to ensure a crisp sear.',
        timerMinutes: '5',
      ));
      _steps.add(_StepDraft(
        title: 'Simmer & Emulsify',
        instruction: 'Add garlic and aromatics, reduce heat to low, and simmer until tender.',
        sensoryCue: 'When garlic is fragrant and the sauce thickens slightly.',
        chefTip: 'Deglaze the skillet with a splash of water or broth.',
        timerMinutes: '10',
      ));

      _goldenRuleControllers.add(TextEditingController(text: 'Always preheat the pan before adding protein.'));
      _goldenRuleControllers.add(TextEditingController(text: 'Taste and adjust seasoning before serving.'));
    }
  }

  void _populateFromExisting(Recipe r) {
    if (_initializedFromExisting) return;
    _initializedFromExisting = true;

    _titleController.text = r.title;
    _subtitleController.text = r.subtitle;
    _prepTimeController.text = r.prepTimeMinutes.toString();
    _cookTimeController.text = r.cookTimeMinutes.toString();
    _servingsController.text = r.baseServings.toString();
    _tagsController.text = r.tags.join(', ');
    _storageTipController.text = r.storageAndReheatingTip;

    _kcalController.text = r.macros.kcal.toString();
    _proteinController.text = r.macros.proteinG.toString();
    _carbsController.text = r.macros.carbsG.toString();
    _fatController.text = r.macros.fatG.toString();

    _selectedCategory = r.category;
    _selectedDifficulty = r.difficulty;

    _ingredients.clear();
    for (final ing in r.ingredients) {
      _ingredients.add(_IngredientDraft(
        name: ing.name,
        amount: ing.amount.toString().replaceAll(RegExp(r'\.0$'), ''),
        unit: ing.unit,
        aisle: ing.aisleCategory,
        buyingTip: ing.buyingTip ?? '',
        substituteOption: ing.substituteOption ?? '',
      ));
    }

    _steps.clear();
    for (final step in r.steps) {
      _steps.add(_StepDraft(
        title: step.title,
        instruction: step.instruction,
        sensoryCue: step.sensoryCue,
        chefTip: step.chefTip,
        timerMinutes: step.timerSeconds != null ? (step.timerSeconds! ~/ 60).toString() : '',
      ));
    }

    for (final ctrl in _goldenRuleControllers) {
      ctrl.dispose();
    }
    _goldenRuleControllers.clear();
    for (final rule in r.chefGoldenRules) {
      _goldenRuleControllers.add(TextEditingController(text: rule));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _tagsController.dispose();
    _storageTipController.dispose();
    _kcalController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();

    for (final ing in _ingredients) {
      ing.dispose();
    }
    for (final step in _steps) {
      step.dispose();
    }
    for (final rule in _goldenRuleControllers) {
      rule.dispose();
    }
    super.dispose();
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_ingredients.isEmpty || _ingredients.every((i) => i.nameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one ingredient with a name.'),
          backgroundColor: MobColors.red,
        ),
      );
      return;
    }

    if (_steps.isEmpty || _steps.every((s) => s.instructionController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one cooking step instruction.'),
          backgroundColor: MobColors.red,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final id = widget.editRecipeId ?? 'user_recipe_${DateTime.now().millisecondsSinceEpoch}';

      final builtIngredients = <RecipeIngredient>[];
      for (final draft in _ingredients) {
        final name = draft.nameController.text.trim();
        if (name.isEmpty) continue;
        final amount = double.tryParse(draft.amountController.text.trim()) ?? 1.0;
        builtIngredients.add(RecipeIngredient(
          name: name,
          amount: amount,
          unit: draft.unit,
          aisleCategory: draft.aisle,
          buyingTip: draft.buyingTipController.text.trim().isEmpty
              ? null
              : draft.buyingTipController.text.trim(),
          substituteOption: draft.substituteController.text.trim().isEmpty
              ? null
              : draft.substituteController.text.trim(),
        ));
      }

      final builtSteps = <RecipeStep>[];
      var stepNum = 1;
      for (final draft in _steps) {
        final instruction = draft.instructionController.text.trim();
        if (instruction.isEmpty) continue;
        final timerMin = int.tryParse(draft.timerMinutesController.text.trim());
        final timerSec = (timerMin != null && timerMin > 0) ? timerMin * 60 : null;

        builtSteps.add(RecipeStep(
          stepNumber: stepNum++,
          title: draft.titleController.text.trim().isEmpty
              ? 'Step ${stepNum - 1}'
              : draft.titleController.text.trim(),
          instruction: instruction,
          sensoryCue: draft.sensoryCueController.text.trim().isEmpty
              ? 'Cook until done and fragrant.'
              : draft.sensoryCueController.text.trim(),
          chefTip: draft.chefTipController.text.trim().isEmpty
              ? 'Take your time and manage heat carefully.'
              : draft.chefTipController.text.trim(),
          timerSeconds: timerSec,
        ));
      }

      final rules = _goldenRuleControllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      final tags = _tagsController.text
          .split(RegExp(r'[,#]'))
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      final newRecipe = Recipe(
        id: id,
        title: _titleController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        category: _selectedCategory,
        prepTimeMinutes: int.tryParse(_prepTimeController.text.trim()) ?? 10,
        cookTimeMinutes: int.tryParse(_cookTimeController.text.trim()) ?? 15,
        baseServings: int.tryParse(_servingsController.text.trim()) ?? 2,
        difficulty: _selectedDifficulty,
        macros: Macros(
          kcal: int.tryParse(_kcalController.text.trim()) ?? 500,
          proteinG: int.tryParse(_proteinController.text.trim()) ?? 30,
          carbsG: int.tryParse(_carbsController.text.trim()) ?? 45,
          fatG: int.tryParse(_fatController.text.trim()) ?? 15,
        ),
        tags: tags,
        chefGoldenRules: rules,
        storageAndReheatingTip: _storageTipController.text.trim(),
        ingredients: builtIngredients,
        steps: builtSteps,
        isBuiltIn: false,
        createdAt: DateTime.now(),
      );

      final repo = ref.read(recipeRepositoryProvider);
      await repo.save(newRecipe);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${newRecipe.title}" saved successfully!'),
            backgroundColor: MobColors.green,
          ),
        );
        context.go('/recipe/${newRecipe.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving recipe: $e'),
            backgroundColor: MobColors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If editing existing, watch recipe
    if (widget.editRecipeId != null && !_initializedFromExisting) {
      final existingAsync = ref.watch(recipeByIdProvider(widget.editRecipeId!));
      existingAsync.whenData((recipe) {
        if (recipe != null) {
          _populateFromExisting(recipe);
        }
      });
    }

    final isEditing = widget.editRecipeId != null;

    return Scaffold(
      backgroundColor: MobColors.background,
      appBar: AppBar(
        backgroundColor: MobColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MobColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isEditing ? 'Edit Custom Recipe' : 'Create Custom Recipe',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _isSaving
                ? const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: MobColors.primary, strokeWidth: 2),
                    ),
                  )
                : TextButton.icon(
                    onPressed: _saveRecipe,
                    style: TextButton.styleFrom(
                      foregroundColor: MobColors.primaryLight,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                    label: const Text('Save'),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            children: [
              // Section 1: Overview
              _buildSectionHeader('1. Recipe Overview', Icons.menu_book_rounded),
              _buildCard([
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: MobColors.textPrimary, fontWeight: FontWeight.w700),
                  decoration: _inputDecoration(
                    label: 'Recipe Title *',
                    hint: 'e.g. Grandma\'s Crispy Lemon Herb Chicken',
                    icon: Icons.dinner_dining,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _subtitleController,
                  maxLines: 2,
                  style: const TextStyle(color: MobColors.textPrimary),
                  decoration: _inputDecoration(
                    label: 'Editorial Subtitle / Hook *',
                    hint: 'e.g. Crisp golden skin, silky pan sauce, and ready in 25 minutes.',
                    icon: Icons.short_text,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a subtitle' : null,
                ),
                const SizedBox(height: 14),
                // Category & Difficulty Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<RecipeCategory>(
                        initialValue: _selectedCategory,
                        dropdownColor: MobColors.surface,
                        decoration: _inputDecoration(label: 'Category', icon: Icons.category_outlined),
                        items: RecipeCategory.values.map((c) {
                          return DropdownMenuItem(
                            value: c,
                            child: Text(c.label, style: const TextStyle(color: MobColors.textPrimary, fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCategory = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<Difficulty>(
                        initialValue: _selectedDifficulty,
                        dropdownColor: MobColors.surface,
                        decoration: _inputDecoration(label: 'Difficulty', icon: Icons.speed_rounded),
                        items: Difficulty.values.map((d) {
                          return DropdownMenuItem(
                            value: d,
                            child: Text(d.label, style: const TextStyle(color: MobColors.textPrimary, fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedDifficulty = val);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Times & Servings Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _prepTimeController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Prep (min)', icon: Icons.timer_outlined),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _cookTimeController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Cook (min)', icon: Icons.local_fire_department_outlined),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _servingsController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Servings', icon: Icons.people_outline),
                      ),
                    ),
                  ],
                ),
              ]),

              const SizedBox(height: 20),

              // Section 2: Nutrition / Macros
              _buildSectionHeader('2. Nutrition per Serving (Macros)', Icons.fitness_center),
              _buildCard([
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _kcalController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Calories (kcal)', icon: Icons.local_fire_department),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _proteinController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Protein (g)', icon: Icons.fitness_center),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _carbsController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Carbs (g)', icon: Icons.grain),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _fatController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: MobColors.textPrimary),
                        decoration: _inputDecoration(label: 'Fat (g)', icon: Icons.water_drop_outlined),
                      ),
                    ),
                  ],
                ),
              ]),

              const SizedBox(height: 20),

              // Section 3: Ingredients
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader('3. Ingredients', Icons.restaurant_menu),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _ingredients.add(_IngredientDraft());
                      });
                    },
                    icon: const Icon(Icons.add, size: 18, color: MobColors.primaryLight),
                    label: const Text('Add Ingredient', style: TextStyle(color: MobColors.primaryLight, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              for (int i = 0; i < _ingredients.length; i++)
                _buildIngredientRow(i, _ingredients[i]),

              const SizedBox(height: 20),

              // Section 4: Cooking Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader('4. Step-by-Step Instructions', Icons.format_list_numbered_rounded),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _steps.add(_StepDraft());
                      });
                    },
                    icon: const Icon(Icons.add, size: 18, color: MobColors.primaryLight),
                    label: const Text('Add Step', style: TextStyle(color: MobColors.primaryLight, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              for (int i = 0; i < _steps.length; i++)
                _buildStepCard(i, _steps[i]),

              const SizedBox(height: 20),

              // Section 5: Chef's Golden Rules & Tips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader('5. Chef\'s Golden Rules', Icons.verified_rounded),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _goldenRuleControllers.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add, size: 18, color: MobColors.gold),
                    label: const Text('Add Rule', style: TextStyle(color: MobColors.gold, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              _buildCard([
                for (int i = 0; i < _goldenRuleControllers.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: MobColors.goldSurface,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text('${i + 1}', style: const TextStyle(color: MobColors.gold, fontWeight: FontWeight.w800, fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _goldenRuleControllers[i],
                          style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                          decoration: _inputDecoration(
                            hint: 'e.g. Always salt pasta water like the sea',
                            label: 'Rule ${i + 1}',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18, color: MobColors.textMuted),
                        onPressed: () {
                          setState(() {
                            _goldenRuleControllers.removeAt(i).dispose();
                          });
                        },
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: _storageTipController,
                  maxLines: 2,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                  decoration: _inputDecoration(
                    label: 'Storage & Reheating Tip',
                    hint: 'e.g. Reheat in a dry skillet over low heat to preserve crispiness.',
                    icon: Icons.inventory_2_outlined,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _tagsController,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                  decoration: _inputDecoration(
                    label: 'Tags (comma-separated)',
                    hint: 'e.g. Dinner, Quick, High Protein, Meal Prep',
                    icon: Icons.tag,
                  ),
                ),
              ]),

              const SizedBox(height: 32),

              // Save Recipe Big Button
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MobColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                icon: const Icon(Icons.check_circle_rounded, size: 22),
                label: Text(
                  isEditing ? 'Save Changes' : 'Create & Save Recipe',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: MobColors.primaryLight),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: MobColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MobColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildIngredientRow(int index, _IngredientDraft ing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MobColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: ing.nameController,
                  style: const TextStyle(color: MobColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 13.5),
                  decoration: _inputDecoration(label: 'Ingredient *', hint: 'e.g. Pancetta'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: ing.amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
                  decoration: _inputDecoration(label: 'Amount', hint: '150'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<MeasurementUnit>(
                  initialValue: ing.unit,
                  dropdownColor: MobColors.surface,
                  decoration: _inputDecoration(label: 'Unit'),
                  items: MeasurementUnit.values.map((u) {
                    return DropdownMenuItem(
                      value: u,
                      child: Text(u.label, style: const TextStyle(color: MobColors.textPrimary, fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => ing.unit = val);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 18, color: MobColors.red),
                tooltip: 'Remove Ingredient',
                onPressed: () {
                  setState(() {
                    _ingredients.removeAt(index).dispose();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<AisleCategory>(
                  initialValue: ing.aisle,
                  dropdownColor: MobColors.surface,
                  decoration: _inputDecoration(label: 'Supermarket Aisle', icon: Icons.storefront_outlined),
                  items: AisleCategory.values.map((a) {
                    return DropdownMenuItem(
                      value: a,
                      child: Text(a.label, style: const TextStyle(color: MobColors.textPrimary, fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => ing.aisle = val);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: ing.buyingTipController,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 12),
                  decoration: _inputDecoration(label: 'Buying Tip (optional)', hint: 'e.g. Aged min 6 months'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(int index, _StepDraft step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MobColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: MobColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: step.titleController,
                  style: const TextStyle(color: MobColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14),
                  decoration: _inputDecoration(label: 'Step Title', hint: 'e.g. Emulsify Carbonara Sauce'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 100,
                child: TextFormField(
                  controller: step.timerMinutesController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                  decoration: _inputDecoration(label: 'Timer (min)', hint: '5'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 18, color: MobColors.red),
                tooltip: 'Remove Step',
                onPressed: () {
                  setState(() {
                    _steps.removeAt(index).dispose();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: step.instructionController,
            maxLines: 3,
            style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
            decoration: _inputDecoration(
              label: 'Step Instruction *',
              hint: 'Describe what the cook should do in detail...',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: step.sensoryCueController,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 12),
                  decoration: _inputDecoration(
                    label: 'Sensory Cue',
                    hint: 'e.g. When glossy, thick, and coats back of spoon',
                    icon: Icons.visibility_outlined,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: step.chefTipController,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 12),
                  decoration: _inputDecoration(
                    label: 'Chef Tip',
                    hint: 'e.g. Keep pan off heat to prevent curdling',
                    icon: Icons.lightbulb_outline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, size: 16, color: MobColors.textSecondary) : null,
      labelStyle: const TextStyle(color: MobColors.textSecondary, fontSize: 12),
      hintStyle: const TextStyle(color: MobColors.textMuted, fontSize: 11.5),
      filled: true,
      fillColor: MobColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: MobColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: MobColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: MobColors.primaryLight, width: 1.5),
      ),
    );
  }
}

class _IngredientDraft {
  _IngredientDraft({
    String name = '',
    String amount = '1',
    this.unit = MeasurementUnit.piece,
    this.aisle = AisleCategory.produce,
    String buyingTip = '',
    String substituteOption = '',
  })  : nameController = TextEditingController(text: name),
        amountController = TextEditingController(text: amount),
        buyingTipController = TextEditingController(text: buyingTip),
        substituteController = TextEditingController(text: substituteOption);

  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController buyingTipController;
  final TextEditingController substituteController;
  MeasurementUnit unit;
  AisleCategory aisle;

  void dispose() {
    nameController.dispose();
    amountController.dispose();
    buyingTipController.dispose();
    substituteController.dispose();
  }
}

class _StepDraft {
  _StepDraft({
    String title = '',
    String instruction = '',
    String sensoryCue = '',
    String chefTip = '',
    String timerMinutes = '',
  })  : titleController = TextEditingController(text: title),
        instructionController = TextEditingController(text: instruction),
        sensoryCueController = TextEditingController(text: sensoryCue),
        chefTipController = TextEditingController(text: chefTip),
        timerMinutesController = TextEditingController(text: timerMinutes);

  final TextEditingController titleController;
  final TextEditingController instructionController;
  final TextEditingController sensoryCueController;
  final TextEditingController chefTipController;
  final TextEditingController timerMinutesController;

  void dispose() {
    titleController.dispose();
    instructionController.dispose();
    sensoryCueController.dispose();
    chefTipController.dispose();
    timerMinutesController.dispose();
  }
}
