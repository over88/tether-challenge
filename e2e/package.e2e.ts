import { sum, subtract } from '../src/index';

describe('E2E Tests', () => {
  it('should perform complex calculations', () => {
    const result1 = sum(10, 20);
    const result2 = subtract(result1, 5);
    const result3 = sum(result2, 15);

    expect(result3).toBe(40);
  });

  it('should handle edge cases in production-like scenario', () => {
    const numbers = [1, 2, 3, 4, 5];
    const total = numbers.reduce((acc, num) => sum(acc, num), 0);

    expect(total).toBe(15);
  });
});